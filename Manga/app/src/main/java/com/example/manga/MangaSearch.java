package com.example.manga;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class MangaSearch extends Fragment {
    private RecyclerView recyclerView;
    private List<Manga> mangaList;
    private List<Author> authorList;
    private String urlTruyen, urlTacgia;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.manga_search, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        getActivity().setTitle("Tìm kiếm");

        mangaList = new ArrayList<>();
        authorList = new ArrayList<>();
        String search_by[] = {"Tên truyện", "Tác giả"};
        Button btnSearch;
        final Spinner spSearchBy;
        final EditText etSearch;

        urlTacgia = "http://"+getString(R.string.ip_address)+"/doctruyenserver/author/find/";
        urlTruyen = "http://"+getString(R.string.ip_address)+"/doctruyenserver/manga/";
        btnSearch = view.findViewById(R.id.btnSearch);
        etSearch = view.findViewById(R.id.etSearch);
        recyclerView = view.findViewById(R.id.rvSearch);
        recyclerView.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getContext());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(linearLayoutManager);

        class SpinnerActivity extends Activity implements AdapterView.OnItemSelectedListener {

            public void onItemSelected(AdapterView<?> parent, View view,
                                       int pos, long id) {
            }

            public void onNothingSelected(AdapterView<?> parent) {
            }
        }
        spSearchBy = view.findViewById(R.id.spSearchBy);
        ArrayAdapter arrayAdapter = new ArrayAdapter(getContext(), android.R.layout.simple_spinner_item, search_by);
        arrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spSearchBy.setAdapter(arrayAdapter);
        spSearchBy.setOnItemSelectedListener(new SpinnerActivity());



        btnSearch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String selectedItem = spSearchBy.getSelectedItem().toString();
                if(selectedItem.equals("Tên truyện")){
                    loadMangaList(urlTruyen + etSearch.getText());
                }else loadAuthorList(urlTacgia + etSearch.getText());

            }
        });
    }

    private void loadMangaList(String url){
        mangaList.clear();
        recyclerView.setAdapter(null);
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {

                Log.d("json", response.toString());

                try {
                    for (int i = 0; i < response.length(); i++) {
                        JSONObject jsonObject = response.getJSONObject(i);
                        Manga item = new Manga();
                        item.setId(jsonObject.getString("mangaId"));
                        item.setTittle(jsonObject.getString("mangaName"));
//                        item.setAuthor(jsonObject.getString("authorName"));
                        item.setStatus(nullText(jsonObject.getString("statusName")));
                        item.setDesc(nullText(jsonObject.getString("describe")));
                        item.setCover(jsonObject.getString("cover"));

                        mangaList.add(item);

                    }
                    MangaAdapter mangaAdapter = new MangaAdapter(mangaList, getActivity().getApplicationContext());
                    recyclerView.setAdapter(mangaAdapter);
                    mangaAdapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    e.printStackTrace();
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
//                progressBar.setVisibility(View.GONE);
                Toast.makeText(getContext(), error.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
        Volley.getInstance().addToRequestQueue(jsonArrayRequest);
    }

    private void loadAuthorList(String url) {
        authorList.clear();
        recyclerView.setAdapter(null);
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                Log.d("json", response.toString());

                try {
                    for (int i = 0; i < response.length(); i++) {
                        JSONObject jsonObject = response.getJSONObject(i);
                        Author item = new Author();
                        item.setId(jsonObject.getString("authorId"));
                        item.setName(jsonObject.getString("authorName"));
                        item.setFacebook(nullText(jsonObject.getString("facebook")));
                        item.setTwitter(nullText(jsonObject.getString("twitter")));
                        authorList.add(item);
                    }
                    AuthorAdapter authorAdapter = new AuthorAdapter(authorList, getActivity().getApplicationContext());
                    recyclerView.setAdapter(authorAdapter);
                    authorAdapter.notifyDataSetChanged();

                } catch (JSONException e) {
                    e.printStackTrace();
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(getActivity().getApplicationContext(), error.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
        Volley.getInstance().addToRequestQueue(jsonArrayRequest);
    }

    private String nullText(String text){
        if(text.equalsIgnoreCase("null")){
            return "chưa có";
        }
        else return text;
    }
}


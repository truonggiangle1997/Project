package com.example.manga;

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
import android.widget.ProgressBar;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.StringRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class RecommenFragment extends Fragment {
    private RecyclerView rvComdedy, rvRomance, rvFantasy;
    private List<Manga> comedyList, romanceList, fantasyList;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.manga_recommen, container, false);

    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        getActivity().setTitle("Truyện đề xuất");


        rvComdedy = view.findViewById(R.id.rvMangaRecommenComedy);
        rvComdedy.setHasFixedSize(true);
        LinearLayoutManager llmComedy = new LinearLayoutManager(getContext());
        llmComedy.setOrientation(LinearLayoutManager.HORIZONTAL);
        rvComdedy.setLayoutManager(llmComedy);
        comedyList = new ArrayList<>();
        loadMangaList("comedy", rvComdedy, comedyList);

        rvRomance = view.findViewById(R.id.rvMangaRecommenRomance);
        rvRomance.setHasFixedSize(true);
        LinearLayoutManager llmRomance = new LinearLayoutManager(getContext());
        llmRomance.setOrientation(LinearLayoutManager.HORIZONTAL);
        rvRomance.setLayoutManager(llmRomance);
        romanceList = new ArrayList<>();
        loadMangaList("romance", rvRomance, romanceList);

        rvFantasy = view.findViewById(R.id.rvMangaRecommenDetective);
        rvFantasy.setHasFixedSize(true);
        LinearLayoutManager llmFantasy = new LinearLayoutManager(getContext());
        llmFantasy.setOrientation(LinearLayoutManager.HORIZONTAL);
        rvFantasy.setLayoutManager(llmFantasy);
        fantasyList = new ArrayList<>();
        loadMangaList("fantasy", rvFantasy, fantasyList);
    }

    private void loadMangaList(String tag, final RecyclerView recyclerView, final List<Manga> mangaList){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/genre/" + tag;
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
                        item.setCover(jsonObject.getString("cover"));

                        mangaList.add(item);

                    }
                    RecommenAdapter recommenAdapter = new RecommenAdapter(mangaList, getActivity().getApplicationContext());
                    recyclerView.setAdapter(recommenAdapter);
                    recommenAdapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(getContext(), error.getMessage(), Toast.LENGTH_LONG).show();
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

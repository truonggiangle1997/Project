package com.example.manga;

import android.arch.lifecycle.Lifecycle;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.helper.ItemTouchHelper;
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

public class MangaFav extends Fragment {
    private RecyclerView recyclerView;
    private List<Manga> mangaList;
    SharedPreferences sp;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.manga_fav, container, false);

    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        getActivity().setTitle("Đang theo dõi");

        sp = getActivity().getSharedPreferences("login", Context.MODE_PRIVATE);

        recyclerView = view.findViewById(R.id.rvMangaFav);
        recyclerView.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getContext());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(linearLayoutManager);

        mangaList = new ArrayList<>();
//        loadMangaList();
//        final Handler handler = new Handler();
//        handler.postDelayed(new Runnable() {
//            @Override
//            public void run() {
//                loadMangaList();
//            }
//        }, 500);
    }

    private void loadMangaList() {
        mangaList.clear();
        recyclerView.setAdapter(null);
        String url = "http://" + getString(R.string.ip_address) + "/doctruyenserver/user/" + sp.getString("userId", "");
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

                    MangaFavAdapter mangaFavAdapter = new MangaFavAdapter(mangaList, getActivity().getApplicationContext());
                    recyclerView.setAdapter(mangaFavAdapter);
                    mangaFavAdapter.notifyDataSetChanged();
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

    private String nullText(String text) {
        if (text.equalsIgnoreCase("null")) {
            return "chưa có";
        } else return text;
    }

    @Override
    public void onResume() {
        super.onResume();
        loadMangaList();
    }
}


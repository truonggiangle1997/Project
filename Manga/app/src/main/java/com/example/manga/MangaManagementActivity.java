package com.example.manga;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.support.annotation.NonNull;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class MangaManagementActivity extends AppCompatActivity {
    private RecyclerView recyclerView;
    private List<Manga> mangaList;
    private FloatingActionButton fabAddManga;
    SharedPreferences sp;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_manga_management);
        setTitle("Quản lý truyện");
        sp = getSharedPreferences("login", Context.MODE_PRIVATE);

        getSupportActionBar().setBackgroundDrawable(new ColorDrawable(Color.WHITE));
        getSupportActionBar().setElevation(0);
        assert getSupportActionBar() != null;
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        fabAddManga = findViewById(R.id.fabAddManga);
        recyclerView = findViewById(R.id.rvMangaManagement);
        recyclerView.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(linearLayoutManager);

        mangaList = new ArrayList<>();
//        loadMangaList();
        fabAddManga.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MangaManagementActivity.this, AddMangaActivity.class));
            }
        });
        recyclerView.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrolled(@NonNull RecyclerView recyclerView, int dx, int dy) {
                if (dy<0) {
                    fabAddManga.show();

                }
                else if(dy>0) {
                    fabAddManga.hide();
                }
            }
        });
    }

    private void loadMangaList() {
        mangaList.clear();
        recyclerView.setAdapter(null);
        String url = "http://" + getString(R.string.ip_address) + "/doctruyenserver/manga/";
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

                    MangaManagementAdapter mangaManagementAdapter = new MangaManagementAdapter(mangaList, getApplicationContext());
                    recyclerView.setAdapter(mangaManagementAdapter);
                    mangaManagementAdapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(getApplicationContext(), error.getMessage(), Toast.LENGTH_LONG).show();
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
    public boolean onSupportNavigateUp() {
        finish();
        return true;
    }

    @Override
    protected void onResume() {
        super.onResume();
        loadMangaList();
    }
}

package com.example.manga;

import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.ProgressBar;
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

public class MangaByTagActivity extends AppCompatActivity {

    private RecyclerView recyclerView;
    private List<Manga> mangaList;
    private ProgressBar pbManga_list;
    private String tag;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.manga_list);

        getSupportActionBar().setBackgroundDrawable(new ColorDrawable(Color.WHITE));
        getSupportActionBar().setElevation(0);
        assert getSupportActionBar() != null;
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        Intent intent = getIntent();
        tag = intent.getStringExtra("TAG");
        setTitle(tag);

        pbManga_list = findViewById(R.id.pbManga_list);
        recyclerView = findViewById(R.id.rvManga_list);
        recyclerView.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getApplicationContext());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(linearLayoutManager);
        mangaList = new ArrayList<>();
        loadMangaList();
    }

    @Override
    public boolean onSupportNavigateUp() {
        finish();
        return true;
    }

    private void loadMangaList(){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/genre/"+tag;
        pbManga_list.setVisibility(View.VISIBLE);
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
                    pbManga_list.setVisibility(View.GONE);
                    MangaAdapter mangaAdapter = new MangaAdapter(mangaList, getApplicationContext());
                    recyclerView.setAdapter(mangaAdapter);
                    mangaAdapter.notifyDataSetChanged();
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

    private String nullText(String text){
        if(text.equalsIgnoreCase("null")){
            return "chưa có";
        }
        else return text;
    }
}

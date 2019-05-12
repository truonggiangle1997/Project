package com.example.manga;

import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
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

public class MangaByAuthorActivity extends AppCompatActivity {

    private TextView tvName;
    private Button btnFacebook, btnTwitter;
    private RecyclerView recyclerView;
    private List<Manga> mangaList;
    private String authorID, authorName, facebook, twitter;
    private Author author;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_manga_by_author);
        setTitle("Tác giả");

        getSupportActionBar().setBackgroundDrawable(new ColorDrawable(Color.WHITE));
        getSupportActionBar().setElevation(0);
        assert getSupportActionBar() != null;
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        tvName = findViewById(R.id.tvMangaByAuthor_name);
        btnFacebook = findViewById(R.id.btnFacebook);
        btnTwitter = findViewById(R.id.btnTwitter);
        recyclerView = findViewById(R.id.rvMangaByAuthor);
        recyclerView.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getApplicationContext());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(linearLayoutManager);

        Intent intent = getIntent();
        authorID = intent.getStringExtra("AUTHORID");
        authorName = intent.getStringExtra("AUTHORNAME");


        author = new Author();
        loadAuthorList();

        mangaList = new ArrayList<>();
        loadMangaList();
    }

    @Override
    public boolean onSupportNavigateUp() {
        finish();
        return true;
    }



    private void loadAuthorList() {
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/author/find/" + authorName;
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                Log.d("json", response.toString());

                try {
                    final JSONObject jsonObject = response.getJSONObject(0);
                    tvName.setText(jsonObject.getString("authorName"));
                    facebook = jsonObject.getString("facebook");
                    twitter = jsonObject.getString("twitter");
                    if(!facebook.equalsIgnoreCase("null"))
                    btnFacebook.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            Intent i = new Intent(Intent.ACTION_VIEW);
                            i.setData(Uri.parse(facebook));
                            startActivity(i);
                        }
                    });
                    if(!twitter.equalsIgnoreCase("null"))
                    btnTwitter.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            Intent i = new Intent(Intent.ACTION_VIEW);
                            i.setData(Uri.parse(twitter));
                            startActivity(i);
                        }
                    });

                } catch (JSONException e) {
                    e.printStackTrace();
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(getApplicationContext(), error.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
        Volley.getInstance().addToRequestQueue(jsonArrayRequest);
    }
    private void loadMangaList(){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/author/" + authorID;
//        pbManga_list.setVisibility(View.VISIBLE);
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
//                    pbManga_list.setVisibility(View.GONE);
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

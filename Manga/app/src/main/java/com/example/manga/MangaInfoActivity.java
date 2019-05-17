package com.example.manga;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class MangaInfoActivity extends AppCompatActivity {
    private ListView listView;
    private List<String> chapterList, chapterId, mangaIdList;
    private List<Tag> tagList;
    private String mangaId, authorName, tittle;
    private Button btnAdd_fav;
    private TextView tvManga_info_tittle, tvManga_info_author, tvManga_info_status, tvManga_info_desc, tvAuthorId;
    private ImageView ivManga_info_cover;
    private RecyclerView rvTags;
    private boolean favStatus;
    SharedPreferences sp;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_manga_info);
        setTitle("Thông tin truyện");

        sp = getSharedPreferences("login", Context.MODE_PRIVATE);

        btnAdd_fav = findViewById(R.id.btnAdd_fav);
        tvManga_info_author = findViewById(R.id.tvManga_info_author);

        getSupportActionBar().setBackgroundDrawable(new ColorDrawable(Color.WHITE));
        getSupportActionBar().setElevation(0);
        assert getSupportActionBar() != null;
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        tvManga_info_tittle = findViewById(R.id.tvManga_info_tittle);
        tvManga_info_status = findViewById(R.id.tvManga_info_status);
        tvManga_info_desc = findViewById(R.id.tvManga_info_desc);
        ivManga_info_cover = findViewById(R.id.ivManga_info_cover);
        tvAuthorId = findViewById(R.id.tvMangaInfo_authorId);
        listView = findViewById(R.id.lvManga_chapters);
        btnAdd_fav = findViewById(R.id.btnAdd_fav);
        rvTags = findViewById(R.id.rvManga_info_tags);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getApplicationContext());
        linearLayoutManager.setOrientation(LinearLayoutManager.HORIZONTAL);
        rvTags.setLayoutManager(linearLayoutManager);

        Intent intent = getIntent();
        mangaId = intent.getStringExtra("ID");
        tittle = intent.getStringExtra("TITTLE");

        tagList = new ArrayList<>();
        loadMangaItem();
        chapterId = new ArrayList<>();
        chapterList = new ArrayList<>();
        loadChapterList();
        mangaIdList = new ArrayList<>();
        if(sp.getBoolean("logged",false) == false){
            btnAdd_fav.setVisibility(View.INVISIBLE);
        }else {
            checkFavStatus();
            btnAdd_fav.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if(favStatus == true){
                        deleteFav();
                        btnAdd_fav.setText("theo dõi");
                        favStatus = false;
                    }else {
                        addFav();
                        btnAdd_fav.setText("bỏ theo dõi");
                        favStatus = true;
                    }

                }
            });
        }
        tvManga_info_author.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/author/find/" + authorName;
                JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
                    @Override
                    public void onResponse(JSONArray response) {
                        Log.d("json", response.toString());

                        try {
                            JSONObject jsonObject = response.getJSONObject(0);
                            Intent intent = new Intent(MangaInfoActivity.this, MangaByAuthorActivity.class);
                            intent.putExtra("AUTHORNAME", authorName);
                            intent.putExtra("AUTHORID", jsonObject.getString("authorId"));
                            startActivity(intent);

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
        });


    }

    @Override
    public boolean onSupportNavigateUp() {
        finish();
        return true;
    }

    private void loadMangaItem() {
        String url = "http://" + getString(R.string.ip_address) + "/doctruyenserver/manga/read/" + mangaId + "/" + tittle;
        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(Request.Method.GET, url, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                Log.d("json", response.toString());

                try {
                    tvManga_info_tittle.setText(response.getString("mangaName"));
                    tvManga_info_author.setText(nullText(response.getString("authorName")));
                    authorName = response.getString("authorName");
                    tvManga_info_status.setText(nullText(response.getString("statusName")));
                    tvManga_info_desc.setText(nullText(response.getString("describe")));
                    Glide.with(getApplicationContext())
                            .load(response.getString("cover"))
                            .diskCacheStrategy(DiskCacheStrategy.ALL)
                            .into(ivManga_info_cover);
                    JSONArray jsonArray = response.getJSONArray("Mangas_Genres");
                    for(int j = 0; j < jsonArray.length(); j++){
                        Tag tag = new Tag();
                        tag.setName(jsonArray.getJSONObject(j).getString("genreName"));
                        tagList.add(tag);
                    }
                    TagAdapter tagAdapter = new TagAdapter(tagList, getApplicationContext());
                    rvTags.setAdapter(tagAdapter);
                    tagAdapter.notifyDataSetChanged();
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
        Volley.getInstance().addToRequestQueue(jsonObjectRequest);
    }

    private void loadChapterList() {
        String url = "http://" + getString(R.string.ip_address) + "/doctruyenserver/chapter/" + mangaId;
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                Log.d("json", response.toString());

                try {
                    for (int i = 0; i < response.length(); i++) {
                        JSONObject jsonObject = response.getJSONObject(i);
                        chapterList.add(jsonObject.getString("chapterNumber"));
                        chapterId.add(jsonObject.getString("chapterId"));
                    }
                    ArrayAdapter<String> arrayAdapter = new ArrayAdapter<String>(getApplicationContext(), android.R.layout.simple_list_item_1, chapterList);
                    listView.setAdapter(arrayAdapter);
                    listView.setOnItemClickListener(listClick);
                    arrayAdapter.notifyDataSetChanged();
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





    private AdapterView.OnItemClickListener listClick = new AdapterView.OnItemClickListener() {
        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
            Intent intent = new Intent(getApplicationContext(), MangaReaderActivity.class);
            intent.putExtra("CHAPTERID", chapterId.get(position));
            intent.putExtra("CHAPTERNUMBER", chapterList.get(position));
            intent.putExtra("TITTLE", tittle);
            intent.putExtra("MANGAID",mangaId);
            startActivity(intent);
        }
    };

    private String nullText(String text){
        if(text.equalsIgnoreCase("null")){
            return "chưa có";
        }
        else return text;
    }

    private void checkFavStatus(){
        String url = "http://" + getString(R.string.ip_address) + "/doctruyenserver/user/" + sp.getString("userId", "");
        mangaIdList.clear();
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                try {
                    for (int i = 0; i < response.length(); i++) {
                        JSONObject jsonObject = response.getJSONObject(i);
                        mangaIdList.add(jsonObject.getString("mangaId"));
                    }
                    if(mangaIdList.contains(mangaId)){
                        favStatus = true;
                        btnAdd_fav.setText("bỏ theo dõi");
                    }else {
                        favStatus = false;
                        btnAdd_fav.setText("theo dõi");
                    }
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


    private void deleteFav(){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/user/" + sp.getString("userId","") + "/" + mangaId;
        StringRequest stringRequest = new StringRequest(Request.Method.DELETE, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Toast.makeText(getApplicationContext(), response, Toast.LENGTH_SHORT).show();
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

            }
        });
        Volley.getInstance().addToRequestQueue(stringRequest);
    }

    private void addFav(){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/user/" + sp.getString("userId","") + "/" + mangaId;
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Toast.makeText(getApplicationContext(), response, Toast.LENGTH_SHORT).show();
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

            }
        });
        Volley.getInstance().addToRequestQueue(stringRequest);
    }


}

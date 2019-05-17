package com.example.manga;

import android.content.Intent;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.CardView;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
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

import static android.os.SystemClock.sleep;

public class MangaReaderActivity extends AppCompatActivity {
    private ArrayList<String> ImgUrl;
    private List<String> chapterList, chapterId;
    private RecyclerView recyclerView;
    private ListView listView;
    private FloatingActionButton fabBack, fabTop;
    private CardView cvNav, cvSelect_chapter;
    private Button btnSelect_chapter, btnPrev_chap, btnNext_chap;
    private String mangaId, tittle, chapterID, chapterNumber;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_manga_reader);

        getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);

        btnSelect_chapter = findViewById(R.id.btnSelect_chapter);
        btnNext_chap = findViewById(R.id.btnNext_chap);
        btnPrev_chap = findViewById(R.id.btnPrev_chap);
        listView = findViewById(R.id.lvSelect_chapter);
        cvNav = findViewById(R.id.cvManga_reader_nav);
        cvSelect_chapter = findViewById(R.id.cvSelect_chapter);
        recyclerView = findViewById(R.id.rvManga_reader);
        final LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(linearLayoutManager);

        fabBack = findViewById(R.id.fabBack);
        fabTop = findViewById(R.id.fabTop);

        Intent intent = getIntent();
        mangaId = intent.getStringExtra("MANGAID");
        tittle = intent.getStringExtra("TITTLE");
        chapterID = intent.getStringExtra("CHAPTERID");
        chapterNumber = intent.getStringExtra("CHAPTERNUMBER");

        btnSelect_chapter.setText("Chap "+chapterNumber);
        cvSelect_chapter.setVisibility(View.GONE);
        chapterList = new ArrayList<>();
        chapterId = new ArrayList<>();
        loadChapterList();

        ImgUrl = new ArrayList<>();
        loadPages(chapterID);


        fabBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        fabTop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                linearLayoutManager.scrollToPositionWithOffset(0,0);
            }
        });

        recyclerView.addOnScrollListener(new RecyclerView.OnScrollListener(){
            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy){
                if (dy<0 && !fabBack.isShown()) {
                    fabBack.show();
                    fabTop.show();
                    cvNav.startAnimation(AnimationUtils.loadAnimation(getApplicationContext(),R.anim.downwards));
                    cvNav.setVisibility(View.VISIBLE);
                }
                else if(dy>0 && fabBack.isShown()) {
                    fabBack.hide();
                    fabTop.hide();
                    cvSelect_chapter.setVisibility(View.GONE);
                    cvNav.startAnimation(AnimationUtils.loadAnimation(getApplicationContext(),R.anim.upwards));
                    cvNav.getAnimation().setAnimationListener(new Animation.AnimationListener() {
                        @Override
                        public void onAnimationStart(Animation animation) {

                        }

                        @Override
                        public void onAnimationEnd(Animation animation) {
                            cvNav.clearAnimation();
                            cvNav.setVisibility(View.GONE);
                            cvNav.setClickable(false);
                        }

                        @Override
                        public void onAnimationRepeat(Animation animation) {

                        }
                    });

                }
            }

            @Override
            public void onScrollStateChanged(RecyclerView recyclerView, int newState) {
                super.onScrollStateChanged(recyclerView, newState);
            }
        });

        btnSelect_chapter.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(cvSelect_chapter.getVisibility() == View.GONE){
                    cvSelect_chapter.setVisibility(View.VISIBLE);

                }else{
                    cvSelect_chapter.setVisibility(View.GONE);
                }
            }
        });

        btnPrev_chap.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                chapterNumber = String.valueOf(Integer.valueOf(chapterNumber) - 1);
                chapterID = chapterId.get(chapterList.indexOf(chapterNumber));
                loadPages(chapterID);
                btnSelect_chapter.setText("Chap " + chapterNumber);
                setBtnVisibility();
            }
        });

        btnNext_chap.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                chapterNumber = String.valueOf(Integer.valueOf(chapterNumber) + 1);
                chapterID = chapterId.get(chapterList.indexOf(chapterNumber));
                loadPages(chapterID);
                btnSelect_chapter.setText("Chap " + chapterNumber);
                setBtnVisibility();
            }
        });
    }

    private void loadChapterList() {
        String url = "http://" + getString(R.string.ip_address) +"/doctruyenserver/chapter/" + mangaId;
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                Log.d("json", response.toString());

                try {
                    for (int i = 0; i < response.length(); i++) {
                        JSONObject jsonObject = response.getJSONObject(i);
                        chapterId.add(jsonObject.getString("chapterId"));
                        chapterList.add(jsonObject.getString("chapterNumber"));
                    }
                    setBtnVisibility();
                    ArrayAdapter<String> arrayAdapter = new ArrayAdapter<String>(getApplicationContext(), R.layout.chapter_list_items, chapterList);
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

    private void loadPages(String chapter) {
        ImgUrl.clear();
        recyclerView.setAdapter(null);
        String url = "http://" + getString(R.string.ip_address) +"/doctruyenserver/page/" + chapter;
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                Log.d("json", response.toString());

                try {
                    for (int i = 0; i < response.length(); i++) {
                        JSONObject jsonObject = response.getJSONObject(i);
                        ImgUrl.add(jsonObject.getString("link1"));
                    }
                    ImageAdapter imageAdapter = new ImageAdapter(getApplicationContext(),ImgUrl);
                    recyclerView.setAdapter(imageAdapter);
                    imageAdapter.notifyDataSetChanged();
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
            chapterNumber = chapterList.get(position);
            chapterID = chapterId.get(position);
            loadPages(chapterID);
            btnSelect_chapter.setText("Chap " + chapterNumber);
            setBtnVisibility();
        }
    };

    private void setBtnVisibility(){
        if(Integer.valueOf(chapterNumber) == 1){
            btnPrev_chap.setVisibility(View.INVISIBLE);
        }else {
            btnPrev_chap.setVisibility(View.VISIBLE);
        }
        if(Integer.valueOf(chapterNumber) >= Integer.valueOf(chapterList.get(chapterList.size()-1))){
            btnNext_chap.setVisibility(View.INVISIBLE);
        }else{
            btnNext_chap.setVisibility(View.VISIBLE);
        }
    }

}

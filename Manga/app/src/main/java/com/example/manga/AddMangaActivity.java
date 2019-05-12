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
import com.android.volley.toolbox.StringRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class AddMangaActivity extends AppCompatActivity {
    private EditText etId, etTittle, etDesc, etCover;
    private Button btnSave;
    private Spinner spTag, spAuthor, spStatus;
    private RecyclerView rvTag;
    private List<Author> authorList;
    private List<Tag> tagList, tempTagList;
    private List<String> tagName, authorName, statusName;
    private EditMangaTagAdapter editMangaTagAdapter;
    private boolean spinnerClicked;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_manga);
        setTitle("Thêm truyện");

        getSupportActionBar().setBackgroundDrawable(new ColorDrawable(Color.WHITE));
        getSupportActionBar().setElevation(0);
        assert getSupportActionBar() != null;
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        etId = findViewById(R.id.etAddManga_id);
        etTittle = findViewById(R.id.etAddManga_tittle);
        etDesc = findViewById(R.id.etAddManga_desc);
        etCover = findViewById(R.id.etAddManga_cover);
        btnSave = findViewById(R.id.btnAddManga_save);
        spAuthor = findViewById(R.id.spAddManga_author);
        spStatus = findViewById(R.id.spAddManga_status);
        spTag = findViewById(R.id.spAddManga_tag);
        rvTag = findViewById(R.id.rvAddManga_tag);
        rvTag.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        linearLayoutManager.setOrientation(LinearLayoutManager.HORIZONTAL);
        rvTag.setLayoutManager(linearLayoutManager);

        tagList = new ArrayList<>();
        tempTagList = new ArrayList<>();
        tagName = new ArrayList<>();
        authorList = new ArrayList<>();
        authorName = new ArrayList<>();
        statusName = new ArrayList<>();
        statusName.add("Processing");
        statusName.add("Stopped");
        statusName.add("Completed");
        ArrayAdapter arrayAdapter = new ArrayAdapter(this, android.R.layout.simple_spinner_item, statusName);
        arrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spStatus.setAdapter(arrayAdapter);
        loadTagList();
        loadAuthorList();

        editMangaTagAdapter = new EditMangaTagAdapter(tagList,getApplicationContext());
        rvTag.setAdapter(editMangaTagAdapter);
        spTag.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                if(spinnerClicked == true){
                    removeTag(tagName.get(position));
                    tagList.add(tempTagList.get(position));
                    editMangaTagAdapter.notifyDataSetChanged();
                }
                spinnerClicked = true;
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
        btnSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                addManga();
                v.postDelayed(new Runnable() {
                    public void run() {
                        updateTag();
                    }
                }, 200);
                finish();

            }
        });
    }

    private void loadTagList(){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/genre/";
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                Log.d("json", response.toString());

                try {
                    for (int i = 0; i < response.length(); i++) {
                        JSONObject jsonObject = response.getJSONObject(i);
                        Tag tag = new Tag();
                        tag.setId(jsonObject.getString("genreId"));
                        tag.setName(jsonObject.getString("genreName"));
                        tempTagList.add(tag);
                        tagName.add(jsonObject.getString("genreName"));
                    }
                    ArrayAdapter arrayAdapter = new ArrayAdapter(getApplicationContext(), android.R.layout.simple_spinner_item, tagName);
                    arrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
                    spTag.setAdapter(arrayAdapter);
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

    private void loadAuthorList(){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/author";
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(Request.Method.GET, url, null, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                Log.d("json", response.toString());

                try {
                    for (int i = 0; i < response.length(); i++) {
                        JSONObject jsonObject = response.getJSONObject(i);
                        Author author = new Author();
                        author.setId(jsonObject.getString("authorId"));
                        author.setName(jsonObject.getString("authorName"));
                        authorList.add(author);
                        authorName.add(jsonObject.getString("authorName"));
                    }
                    ArrayAdapter arrayAdapter = new ArrayAdapter(getApplicationContext(), android.R.layout.simple_spinner_item, authorName);
                    arrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
                    spAuthor.setAdapter(arrayAdapter);
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

    private void addManga(){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/manga/"+ etId.getText() +"/"
                +etTittle.getText()+"/"+authorList.get(spAuthor.getSelectedItemPosition()).getId()+"/"
                +String.valueOf(spStatus.getSelectedItemPosition()+1)+"/"+etDesc.getText()+"/"+StringToHex(etCover.getText().toString());

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

    private void removeTag(String tagName){
        for(int i = 0; i < tagList.size(); i++){
            if(tagList.get(i).getName().equalsIgnoreCase(tagName)){
                tagList.remove(i);
                editMangaTagAdapter.notifyItemRemoved(i);
            }
        }
    }

    private void updateTag(){
        for (int i = 0; i < tagList.size(); i++){
            addTag(tagList.get(i).getId());
        }
    }

    private void addTag(String tagId){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/manga/" + etId.getText() + "/" + tagId;

        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

            }
        });
        Volley.getInstance().addToRequestQueue(stringRequest);
    }

    private String StringToHex(String str){

        char[] chars = str.toCharArray();

        StringBuffer hex = new StringBuffer();
        for(int i = 0; i < chars.length; i++){
            hex.append(Integer.toHexString((int)chars[i]));
        }

        return hex.toString();
    }
    @Override
    public boolean onSupportNavigateUp() {
        finish();
        return true;
    }
}

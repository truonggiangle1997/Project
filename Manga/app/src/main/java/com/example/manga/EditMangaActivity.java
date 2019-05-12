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

public class EditMangaActivity extends AppCompatActivity {
    private EditText etId, etTittle, etDesc, etCover;
    private Button btnSave;
    private Spinner spTag, spAuthor, spStatus;
    private RecyclerView rvTag;
    private String Id, tittle;
    private List<Author> authorList;
    private List<Tag> tagList, tempTagList, oldTagList;
    private List<String> tagName, authorName, statusName;
    private EditMangaTagAdapter editMangaTagAdapter;
    private boolean spinnerClicked;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_manga);
        setTitle("Sửa thông tin truyện");

        getSupportActionBar().setBackgroundDrawable(new ColorDrawable(Color.WHITE));
        getSupportActionBar().setElevation(0);
        assert getSupportActionBar() != null;
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        Intent intent = getIntent();
        Id = intent.getStringExtra("ID");
        tittle = intent.getStringExtra("TITTLE");

        etId = findViewById(R.id.etEditManga_id);
        etTittle = findViewById(R.id.etEditManga_tittle);
        etDesc = findViewById(R.id.etEditManga_desc);
        etCover = findViewById(R.id.etEditManga_cover);
        btnSave = findViewById(R.id.btnEditManga_save);
        spAuthor = findViewById(R.id.spEditManga_author);
        spStatus = findViewById(R.id.spEditManga_status);
        spTag = findViewById(R.id.spEditManga_tag);
        rvTag = findViewById(R.id.rvEditManga_tag);
        rvTag.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        linearLayoutManager.setOrientation(LinearLayoutManager.HORIZONTAL);
        rvTag.setLayoutManager(linearLayoutManager);

        etId.setText(Id);
        tagList = new ArrayList<>();
        tempTagList = new ArrayList<>();
        oldTagList = new ArrayList<>();
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
        loadMangaInfo();

        editMangaTagAdapter = new EditMangaTagAdapter(tagList,getApplicationContext());
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
                editManga();
                deleteOldTag();
                updateTag();
                finish();
            }
        });
    }

    private void loadMangaInfo() {
        String url = "http://" + getString(R.string.ip_address) + "/doctruyenserver/manga/read/" + Id + "/" + tittle;
        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(Request.Method.GET, url, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                Log.d("json", response.toString());

                try {
                    etTittle.setText(response.getString("mangaName"));
                    ArrayAdapter authorAdapter = (ArrayAdapter) spAuthor.getAdapter();
                    spAuthor.setSelection(authorAdapter.getPosition(response.getString("authorName")));
                    ArrayAdapter statusAdapter = (ArrayAdapter) spStatus.getAdapter();
                    spStatus.setSelection(statusAdapter.getPosition(response.getString("statusName")));
                    etDesc.setText(response.getString("describe"));
                    etCover.setText(response.getString("cover"));
                    JSONArray jsonArray = response.getJSONArray("Mangas_Genres");
                    for(int j = 0; j < jsonArray.length(); j++){
                        Tag tag = new Tag();
                        tag.setId(jsonArray.getJSONObject(j).getString("genreId"));
                        tag.setName(jsonArray.getJSONObject(j).getString("genreName"));
                        tagList.add(tag);
                        oldTagList.add(tag);
                    }
                    rvTag.setAdapter(editMangaTagAdapter);
                    editMangaTagAdapter.notifyDataSetChanged();
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

    private void editManga(){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/manga/"+ Id +"/"
                +etTittle.getText()+"/"+authorList.get(spAuthor.getSelectedItemPosition()).getId()+"/"
                +String.valueOf(spStatus.getSelectedItemPosition()+1)+"/"+etDesc.getText()+"/"+StringToHex(etCover.getText().toString());

        StringRequest stringRequest = new StringRequest(Request.Method.PUT, url, new Response.Listener<String>() {
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

    private void deleteOldTag(){
        for (int i = 0; i < oldTagList.size(); i++){
            deleteTag(oldTagList.get(i).getId());
        }
    }

    private void deleteTag(String tagId){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/manga/" + Id + "/" + tagId;

        StringRequest stringRequest = new StringRequest(Request.Method.DELETE, url, new Response.Listener<String>() {
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

    private void updateTag(){
        for (int i = 0; i < tagList.size(); i++){
            addTag(tagList.get(i).getId());
        }
    }

    private void addTag(String tagId){
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/manga/" + Id + "/" + tagId;

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

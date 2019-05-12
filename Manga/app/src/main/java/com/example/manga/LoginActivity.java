package com.example.manga;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONException;
import org.json.JSONObject;

public class LoginActivity extends AppCompatActivity {
    private Button btnLogin, btnSign_up;
    private EditText etUser, etPass;
    SharedPreferences sp;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        setTitle("Đăng nhập");

        getSupportActionBar().setBackgroundDrawable(new ColorDrawable(Color.WHITE));
        getSupportActionBar().setElevation(0);
        assert getSupportActionBar() != null;
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        sp = getSharedPreferences("login", Context.MODE_PRIVATE);

        etUser = findViewById(R.id.etLogin_user);
        etPass = findViewById(R.id.etLogin_pass);
        btnLogin = findViewById(R.id.btnLogin);
        btnSign_up = findViewById(R.id.btnSignUp_redirect);

        btnLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Login();
            }
        });
        btnSign_up.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(LoginActivity.this, SignUpActivity.class));
            }
        });
    }

    public void Login() {
        String url = "http://"+getString(R.string.ip_address)+"/doctruyenserver/user/" + etUser.getText()+"/"+ etPass.getText() ;
        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(Request.Method.GET, url, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                try {
                    if(response.length()!=0){
                        sp.edit().putBoolean("logged",true).apply();
                        sp.edit().putString("userId",response.getString("userId")).apply();
                        sp.edit().putString("name",response.getString("name")).apply();
                        sp.edit().putString("roleId",response.getString("roleId")).apply();
                        Toast.makeText(getApplicationContext(), "Đăng nhập thành công", Toast.LENGTH_SHORT).show();
                        finish();
                        startActivity(new Intent(LoginActivity.this, MainActivity.class));
                    }

                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(getApplicationContext(), "Tên đang nhập hoặc mật khẩu không đúng", Toast.LENGTH_LONG).show();
                etPass.setText("");
            }
        });
        Volley.getInstance().addToRequestQueue(jsonObjectRequest);
    }

    @Override
    public boolean onSupportNavigateUp(){
        finish();
        return true;
    }
}

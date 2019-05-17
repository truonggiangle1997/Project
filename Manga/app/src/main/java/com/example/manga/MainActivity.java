package com.example.manga;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {
    private NavigationView navigationView;
    SharedPreferences sp;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        sp = getSharedPreferences("login", Context.MODE_PRIVATE);
        loadFragment(R.id.nav_recommendations);
    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            startActivity(new Intent(this, SettingActivity.class));
        }

        return super.onOptionsItemSelected(item);
    }

    private void loadFragment(int id){
        Fragment fragment = null;
        switch (id){
            case R.id.nav_recommendations:
                fragment = new RecommenFragment();
                break;
            case R.id.nav_list:
                fragment = new MangaList();
                break;
            case R.id.nav_search:
                fragment = new MangaSearch();
                break;
            case R.id.nav_tag:
                fragment = new MangaTag();
                break;
            case R.id.nav_fav:
                fragment = new MangaFav();
                break;
        }

        if(fragment != null){
            FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
            ft.replace(R.id.content_main, fragment);
            ft.commit();
        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
    }

    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();
        switch (id){
            case R.id.nav_login:
                startActivity(new Intent(MainActivity.this, LoginActivity.class));
                break;
            case R.id.nav_manga_management:
                startActivity(new Intent(MainActivity.this, MangaManagementActivity.class));
                break;
            case R.id.nav_logout:
                sp.edit().putBoolean("logged",false).apply();
                Toast.makeText(this, "Đã đăng xuất", Toast.LENGTH_SHORT).show();
                finish();
                startActivity(new Intent(MainActivity.this, MainActivity.class));
                break;
        }

        loadFragment(id);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }
    private void LoggedAdmin(){
        navigationView = findViewById(R.id.nav_view);
        Menu nav_menu = navigationView.getMenu();
        View header = navigationView.getHeaderView(0);
        TextView username = header.findViewById(R.id.tvUsername);
        username.setText(sp.getString("name",""));
        nav_menu.findItem(R.id.nav_fav).setVisible(true);
        nav_menu.findItem(R.id.nav_login).setVisible(false);
        nav_menu.findItem(R.id.nav_logout).setVisible(true);
        nav_menu.findItem(R.id.nav_manga_management).setVisible(true);
    }

    private void LoggedMember(){
        navigationView = findViewById(R.id.nav_view);
        Menu nav_menu = navigationView.getMenu();
        View header = navigationView.getHeaderView(0);
        TextView username = header.findViewById(R.id.tvUsername);
        username.setText(sp.getString("name",""));
        nav_menu.findItem(R.id.nav_fav).setVisible(true);
        nav_menu.findItem(R.id.nav_login).setVisible(false);
        nav_menu.findItem(R.id.nav_logout).setVisible(true);
    }

    private void LoggedOut(){
        navigationView = findViewById(R.id.nav_view);
        Menu nav_menu = navigationView.getMenu();
        View header = navigationView.getHeaderView(0);
        TextView username = header.findViewById(R.id.tvUsername);
        username.setText("Chưa đăng nhập");
        nav_menu.findItem(R.id.nav_fav).setVisible(false);
        nav_menu.findItem(R.id.nav_login).setVisible(true);
        nav_menu.findItem(R.id.nav_logout).setVisible(false);
        nav_menu.findItem(R.id.nav_manga_management).setVisible(false);
    }

    private void checkLoginStatus(){
        if(sp.getBoolean("logged",false)&&sp.getString("roleId","").equalsIgnoreCase("1")){
            LoggedAdmin();
        }else if(sp.getBoolean("logged",false)&&sp.getString("roleId","").equalsIgnoreCase("2")){
            LoggedMember();
        }else LoggedOut();
    }

    @Override
    protected void onResume() {
        super.onResume();
        checkLoginStatus();
    }
}

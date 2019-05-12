package com.example.manga;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;

import java.util.List;

public class MangaFavAdapter extends RecyclerView.Adapter<MangaFavAdapter.MangaViewHolder> {
    private List<Manga> mangaList;
    private Context mContext;
    SharedPreferences sp;
    public MangaFavAdapter(List<Manga> mangalist, Context mcontext) {
        this.mangaList = mangalist;
        this.mContext = mcontext;
    }

    @Override
    public MangaViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int i) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.manga_fav_item, parent, false);
        return new MangaViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull final MangaViewHolder mangaViewHolder, final int position) {
        final Manga manga = mangaList.get(position);
        mangaViewHolder.id = manga.getId();
        mangaViewHolder.tvTittle.setText(manga.getTittle());
        Glide.with(mContext)
                .load(manga.getCover())
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .into(mangaViewHolder.ivCover);
        mangaViewHolder.btnDelete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                deleteFav(mangaViewHolder.id);
                mangaList.remove(position);
                notifyItemRemoved(position);
            }
        });
    }

    @Override
    public int getItemCount() {
        return mangaList.size();
    }

    public class MangaViewHolder extends RecyclerView.ViewHolder {
        protected TextView tvTittle;
        protected ImageView ivCover;
        protected Button btnDelete;
        protected String id;

        public MangaViewHolder(View view){
            super(view);
            tvTittle = view.findViewById(R.id.tvMangaManagement_tittle);
            ivCover = view.findViewById(R.id.ivMangaManagement_cover);
            btnDelete = view.findViewById(R.id.btnMangaFav_delete);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(v.getContext(), MangaInfoActivity.class);
                    intent.putExtra("ID", id);
                    intent.putExtra("TITTLE", tvTittle.getText());
                    v.getContext().startActivity(intent);
                }
            });
        }
    }
    private void deleteFav(String mangaId){
        sp = mContext.getSharedPreferences("login", Context.MODE_PRIVATE);
        String url = "http://"+mContext.getString(R.string.ip_address)+"/doctruyenserver/user/" + sp.getString("userId","") + "/" + mangaId;

        StringRequest stringRequest = new StringRequest(Request.Method.DELETE, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Toast.makeText(mContext, response, Toast.LENGTH_SHORT).show();
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

            }
        });
        Volley.getInstance().addToRequestQueue(stringRequest);
    }


}


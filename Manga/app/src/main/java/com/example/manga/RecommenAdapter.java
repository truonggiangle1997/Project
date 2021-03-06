package com.example.manga;
import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;

import java.util.List;

public class RecommenAdapter extends RecyclerView.Adapter<RecommenAdapter.MangaViewHolder> {
    private List<Manga> mangaList;
    private Context mContext;

    public RecommenAdapter(List<Manga> mangalist, Context mcontext) {
        this.mangaList = mangalist;
        this.mContext = mcontext;
    }

    @Override
    public MangaViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int i) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.manga_recommen_item, parent, false);
        return new MangaViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull MangaViewHolder mangaViewHolder, int position) {
        Manga manga = mangaList.get(position);
        mangaViewHolder.id = manga.getId();
        mangaViewHolder.tvTittle.setText(manga.getTittle());
        Glide.with(mContext)
                .load(manga.getCover())
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .into(mangaViewHolder.ivCover);


    }

    @Override
    public int getItemCount() {
        return mangaList.size();
    }

    public static class MangaViewHolder extends RecyclerView.ViewHolder {
        protected TextView tvTittle;
        protected ImageView ivCover;
        protected String id;

        public MangaViewHolder(View view){
            super(view);
            tvTittle = view.findViewById(R.id.tvMangaRecommenTittle);

            ivCover = view.findViewById(R.id.ivMangaRecommenCover);
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


}


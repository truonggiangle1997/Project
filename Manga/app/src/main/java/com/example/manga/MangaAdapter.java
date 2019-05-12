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

public class MangaAdapter extends RecyclerView.Adapter<MangaAdapter.MangaViewHolder> {
    private List<Manga> mangaList;
    private Context mContext;

    public MangaAdapter(List<Manga> mangalist, Context mcontext) {
        this.mangaList = mangalist;
        this.mContext = mcontext;
    }

    @Override
    public MangaViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int i) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.manga_list_item, parent, false);
        return new MangaViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull MangaViewHolder mangaViewHolder, int position) {
        Manga manga = mangaList.get(position);
        mangaViewHolder.id = manga.getId();
        mangaViewHolder.tvTittle.setText(manga.getTittle());
//        mangaViewHolder.tvAuthor.setText(manga.getAuthor());
        mangaViewHolder.tvStatus.setText(String.valueOf(manga.getStatus()));
        mangaViewHolder.tvDesc.setText(manga.getDesc());
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
        protected TextView tvTittle, tvAuthor, tvStatus, tvDesc;
        protected ImageView ivCover;
        protected String id;

        public MangaViewHolder(View view){
            super(view);
            tvTittle = view.findViewById(R.id.tvManga_list_tittle);
//            tvAuthor = view.findViewById(R.id.tvManga_list_author);
            tvStatus = view.findViewById(R.id.tvManga_list_status);
            tvDesc = view.findViewById(R.id.tvManga_list_desc);
            ivCover = view.findViewById(R.id.ivManga_list_cover);
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


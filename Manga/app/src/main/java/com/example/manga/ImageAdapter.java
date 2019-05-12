package com.example.manga;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.github.chrisbanes.photoview.PhotoView;

import java.util.ArrayList;

public class ImageAdapter extends RecyclerView.Adapter<ImageAdapter.ViewHolder> {
    private Context mContext;
    private ArrayList<String> ImgUrl;

    public ImageAdapter(Context mContext, ArrayList<String> imgUrl) {
        this.mContext = mContext;
        ImgUrl = imgUrl;
    }

    public static class ViewHolder extends RecyclerView.ViewHolder{
        private PhotoView imageView;
        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            imageView = itemView.findViewById(R.id.pvManga_reader_item);
        }

        public ImageView getImage(){
            return this.imageView;
        }
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int i) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.manga_reader_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder viewHolder, int position) {
        Glide.with(mContext)
                .load(ImgUrl.get(position))
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .into(viewHolder.getImage());
    }

    @Override
    public int getItemCount() {
        return ImgUrl.size();
    }
}

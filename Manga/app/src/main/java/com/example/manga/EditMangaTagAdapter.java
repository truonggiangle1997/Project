package com.example.manga;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import java.util.List;

public class EditMangaTagAdapter extends RecyclerView.Adapter<EditMangaTagAdapter.EditMangaTagViewHolder> {
    private List<Tag> tagList;
    private Context context;

    public EditMangaTagAdapter(List<Tag> tagList, Context context) {
        this.tagList = tagList;
        this.context = context;
    }

    @NonNull
    @Override
    public EditMangaTagAdapter.EditMangaTagViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.tag_list_items, viewGroup,false);
        return new EditMangaTagViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull EditMangaTagAdapter.EditMangaTagViewHolder tagViewHolder, final int i) {
        final Tag tag = tagList.get(i);
        tagViewHolder.id = tag.getId();
        tagViewHolder.tvTag.setText(tag.getName());
        tagViewHolder.tvTag.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tagList.remove(i);
                notifyItemRemoved(i);
                notifyDataSetChanged();
            }
        });
    }

    @Override
    public int getItemCount() {
        return tagList.size();
    }

    public static class EditMangaTagViewHolder extends RecyclerView.ViewHolder{
        protected TextView tvTag;
        protected String id;

        public EditMangaTagViewHolder(@NonNull View itemView) {
            super(itemView);
            tvTag = itemView.findViewById(R.id.tvTag_item);
        }
    }
}

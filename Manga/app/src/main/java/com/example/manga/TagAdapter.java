package com.example.manga;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.List;

public class TagAdapter extends RecyclerView.Adapter<TagAdapter.TagViewHolder> {
    private List<Tag> tagList;
    private Context context;

    public TagAdapter(List<Tag> tagList, Context context) {
        this.tagList = tagList;
        this.context = context;
    }

    @NonNull
    @Override
    public TagAdapter.TagViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.tag_list_items, viewGroup,false);
        return new TagViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull TagAdapter.TagViewHolder tagViewHolder, int i) {
        Tag tag = tagList.get(i);
        tagViewHolder.id = tag.getId();
        tagViewHolder.tvTag.setText(tag.getName());
    }

    @Override
    public int getItemCount() {
        return tagList.size();
    }

    public static class TagViewHolder extends RecyclerView.ViewHolder{
        protected TextView tvTag;
        protected String id;

        public TagViewHolder(@NonNull View itemView) {
            super(itemView);
            tvTag = itemView.findViewById(R.id.tvTag_item);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(v.getContext(), MangaByTagActivity.class);
                    intent.putExtra("TAG", tvTag.getText());
                    v.getContext().startActivity(intent);
                }
            });
        }
    }
}

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

public class AuthorAdapter extends RecyclerView.Adapter<AuthorAdapter.AuthorViewHolder> {
    private List<Author> authorList;
    private Context mContext;

    public AuthorAdapter(List<Author> authorlist, Context mcontext) {
        this.authorList = authorlist;
        this.mContext = mcontext;
    }

    @NonNull
    @Override
    public AuthorViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.author_list_item, viewGroup, false);
        return new AuthorViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull AuthorViewHolder authorViewHolder, int i) {
        Author author = authorList.get(i);
        authorViewHolder.authorId = author.getId();
        authorViewHolder.tvAuthor_name.setText(author.getName());
        authorViewHolder.tvAuthor_facebook.setText(author.getFacebook());
        authorViewHolder.tvAuthor_twitter.setText(author.getTwitter());
    }

    @Override
    public int getItemCount() {
        return authorList.size();
    }

    public static class AuthorViewHolder extends RecyclerView.ViewHolder {
        protected TextView tvAuthor_name, tvAuthor_facebook, tvAuthor_twitter;
        protected String authorId;
        public AuthorViewHolder(@NonNull View itemView) {
            super(itemView);
            tvAuthor_name = itemView.findViewById(R.id.tvAuthor_name);
            tvAuthor_facebook = itemView.findViewById(R.id.tvAuthor_facebook);
            tvAuthor_twitter = itemView.findViewById(R.id.tvAuthor_twitter);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(v.getContext(), MangaByAuthorActivity.class);
                    intent.putExtra("AUTHORID", authorId);
                    intent.putExtra("AUTHORNAME", tvAuthor_name.getText());
                    v.getContext().startActivity(intent);
                }
            });
        }
    }
}

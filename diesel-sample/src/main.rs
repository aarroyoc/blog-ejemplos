#[macro_use]
extern crate diesel;

use diesel::prelude::*;
use diesel::sqlite::SqliteConnection;
use self::schema::*;

mod schema;

#[derive(Queryable)]
struct Post{
    id: i32,
    title: String,
    content: String,
}

#[derive(Insertable)]
#[table_name="post"]
struct PostInsert{
    id: i32,
    title: String,
    content: String,
}

#[derive(QueryableByName)]
#[table_name="post"]
struct PostRaw {
    id: i32,
    title: String,
}

fn main() {
    let conn = SqliteConnection::establish("db.sqlite3").unwrap();

    let posts = post::table
        .filter(post::id.gt(1))
        .load::<Post>(&conn)
        .unwrap();
    for post in posts {
        println!("Title: {}\tContent: {}", post.title, post.content);
    }

    let posts = post::table
        .select(post::title)
        .load::<String>(&conn)
        .unwrap();
    for post_title in posts {
        println!("Title: {}", post_title);
    }

    let new_post = PostInsert {
        id: 5,
        title: "Test".to_string(),
        content: "Lorem Ipsum".to_string(),
    };

    diesel::insert_into(post::table)
        .values(&new_post)
        .execute(&conn);

    let posts = diesel::sql_query("SELECT id,title FROM post WHERE id > 0").load::<PostRaw>(&conn).unwrap();
    for post in posts {
        println!("Title: {}\tID: {}", post.title, post.id);
    }

    diesel::update(post::table.find(1))
        .set(post::title.eq("Título actualizado".to_string()))
        .execute(&conn);

    diesel::delete(post::table.find(1))
        .execute(&conn);


}

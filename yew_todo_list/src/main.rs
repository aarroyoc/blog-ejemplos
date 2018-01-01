#[macro_use]
extern crate yew;

use yew::html::*;

struct Model {
    id: u32,
    tasks: Vec<Task>,
    input: String,
}

struct Task{
    content: String,
    id: u32,
}

enum Msg {
    Add,
    Remove(u32),
    Change(String),
    None,
}

fn update(context: &mut Context<Msg>, model: &mut Model, msg: Msg) {
    match msg {
        Msg::Add => {
            let task = Task{
                content: model.input.clone(),
                id: model.id,
            };
            model.tasks.push(task);
            model.id += 1;
        }
        Msg::Change(content) => {
            model.input = content;
        }
        Msg::Remove(id) => {
            let mut i = 0;
            for task in model.tasks.iter(){
                if task.id == id{
                    break;
                }
                i+=1;
            }
            model.tasks.remove(i);
        }
        _ => {

        }
    }
}

fn view(model: &Model) -> Html<Msg> {
    html! {
        <div>
            <ul>
            { for model.tasks.iter().map(view_task) }
            </ul>
            <input type="text", value=&model.input, oninput=|e: InputData| Msg::Change(e.value), onkeypress=|e: KeyData|{
                if e.key == "Enter" {
                    Msg::Add
                }else{
                    Msg::None
                }
            }, /> 
        </div>
    }
}

fn view_task(task: &Task) -> Html<Msg>{
    let id = task.id;
    html!{
        <li><span>{&task.content}</span><button onclick=move |_| Msg::Remove(id),>{format!("X")}</button></li>
    }
}

fn main() {
    let model = Model {
        id: 0,
        tasks: vec![],
        input: String::from("")
    };
    program(model, update, view);
}


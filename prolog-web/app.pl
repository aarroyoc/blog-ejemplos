:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_client)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_authenticate)).
:- use_module(library(http/http_unix_daemon)).


:- http_handler(/,index,[]).
:- http_handler(root(user/User),user(User),[method(get)]).
:- http_handler('/foto.jpg',static,[]).
:- http_handler('/api',api,[]).
:- http_handler('/form',form,[]).

auth(Request) :-
    Realm = 'Prolog WebApp',
    (
        string_codes("123456789",Password),
        member(authorization(Header),Request),http_authorization_data(Header,basic(admin,Password)) -> true
        ;
        throw(http_reply(authorise(basic, Realm)))
    ).

index(_Request) :-
    reply_html_page(
        title('Prolog WebApp'),
        [\index_body]).

index_body -->
    html([
        h1('Prolog WebApp'),
        p([style('color: red'),id('parrafo')],'Hola Mundo'),
        form([action='/form',method=post],[
            input([name('email'),type('text')]),
            input([type('submit')])  
        ])
    ]).

form(Request) :-
    http_read_data(Request,Data,[]),
    member(email=Email,Data),
    format('Content-Type: text/plain~n~n'),
    format('El correo indicado es: '),
    format(Email).

api(_Request) :-
    reply_json(json([
       name('Alonso Quijana'),
       email('quijana@mail.xp') 
    ])).

user(User,Request) :-
    auth(Request),
    format('Content-Type: text/plain~n~n'),
    format('Usuario: '),
    format(User).

static(Request) :-
    http_reply_file('burgos.jpeg',[],Request).

:- http_daemon([port(4777),fork(false)]).

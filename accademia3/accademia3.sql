create type Strutturato as enum (
    "Ricercatore", "Professore Associato", "Professore Ordinario"
)

create type LavoroProgetto as enum (
     "Ricerca e Sviluppo", "Dimostrazione", "Management", "Altro"
)

create type CausaAssenza as enum (
    "Chiusura Universitaria", "Maternita", "Malattia"
)

create domain PoslInteger as INTEGER
    default 0
    check(value >= 0)

create domain StringaM as varchar
    default 0
    check(value < 100)

create domain NumeroOre as INTEGER
    default 0
check ( value >= 0 and value <= 8)


create domain Denaro as REAL
    default 0
    check(value >= 0)





create TABLE Persona(
    id IPoslInteger NOT NULL,
    nome StringaM NOT NULL, 
    cognome StringaM NOT NULL,
    posizione Strutturato NOT NULL, 
    stipendio Denaro NOT NULL,
    primary key(id)
)

create TABLE Progetto(
    id IPoslInteger NOT NULL,
    nome StringaM NOT NULL, 
    inizio date NOT NULL,
    fine date NOT NULL,
    budget Denaro NOT NULL,
    primary key (id),
    unique (nome),
        check(inizio < fine)
    )

create TABLE WP(
    progetto PoslInteger NOT NULL,
    id IPoslInteger NOT NULL,
    nome StringaM NOT NULL, 
    inizio date NOT NULL,
    fine date NOT NULL,
    primary key(id),
    foreign key (progetto) as reference Progetto(id),
    unique (progetto,nome),
        check(inizio < fine)
)

create TABLE AttivitaProgetto(
    progetto PoslInteger NOT NULL,
    id IPoslInteger NOT NULL,
    wp IPoslInteger NOT NUll,
    Persona IPoslInteger NOT NULL,
    tipo LavoroProgetto NOT NULL, 
    giorno date NOT NULL,
    oreDurata NumeroOre NOT NULL,
    primary key(id),
    foreign key (progetto,wp) as reference WP(progetto,id),
    foreign key(persona)as reference Persona(id)
)

create TABLE AttivitaNonProgettuale(
    id IPoslInteger NOT NULL,
    Persona IPoslInteger NOT NULL,
    tipo LavoroNonProgettuale NOT NULL, 
    giorno date NOT NULL,
    oreDurata NumeroOre NOT NULL,
    primary key(id),
    foreign key(persona)as reference Persona(id)
)

create TABLE Assenza(
    id IPoslInteger NOT NULL,
    Persona IPoslInteger NOT NULL,
    tipo CausaAssenza NOT NULL, 
    giorno date NOT NULL,
    primary key(id),
    foreign key (progetto,wp) as reference WP(progetto,id),
    unique (persona,giorno)
)

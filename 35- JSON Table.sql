CREATE TABLE X(Y JSON);

INSERT INTO X VALUES ('{"HOBBY": 
[{"nome": "PRAIA", "local": "Ar Livre"}, 
{"nome":"FUTEBOL", "local":"Ar Livre"},
{"nome": "CINEMA", "local": "Fechado"}]}');

select Y from X;

select JSON_UNQUOTE(JSON_EXTRACT(Y, "$.HOBBY[0].nome")) as NOME, JSON_UNQUOTE(JSON_EXTRACT(Y, "$.HOBBY[0].local")) as local FROM x
union
select JSON_EXTRACT(Y, "$.HOBBY[1].nome") as NOME, JSON_EXTRACT(Y, "$.HOBBY[1].local") as local FROM X
union
select JSON_EXTRACT(Y, "$.HOBBY[2].nome") as NOME, JSON_EXTRACT(Y, "$.HOBBY[2].local") as local FROM X;


select T2.NOME, T2.LOCAL from X
CROSS JOIN
JSON_TABLE (JSON_EXTRACT(Y, "$.HOBBY"), "$[*]"
COLUMNS(
NOME VARCHAR(15) PATH "$.nome", LOCAL VARCHAR(15) PATH "$.local")) T2

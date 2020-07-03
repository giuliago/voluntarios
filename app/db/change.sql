create table tb_perfilusuario_backup (
pk_idusuario INTEGER PRIMARY KEY,
nome VARCHAR(60),
uk_email VARCHAR(45),
senha VARCHAR(45),
nascimento DATETIME,
regiao VARCHAR(45));

drop table tb_perfilusuario;

alter table tb_perfilusuario_backup rename to tb_perfilusuario;
-- 핫딜 상품 테이블 
drop table h_product;
CREATE TABLE h_product (
  h_p_num INT auto_increment primary KEY,
  h_p_category VARCHAR(45) default '카테고리',
  h_p_name VARCHAR(45),
  h_p_price INT,
  h_p_quantity INT,
  h_p_desc TEXT,
  h_p_date datetime default now() not null,
  constraint fk_h_c_category foreign key (h_p_category) references h_category(c_name)
);
select * from h_product;

-- 핫딜 상품 이미지
drop table h_p_image;
create table h_p_image(
	h_p_i_num int auto_increment primary key,
    h_p_pnum int not null, -- fk
    h_p_orifilename varchar(100) not null,
    h_p_sysfilename varchar(100) not null,
    constraint fk_h_p_num foreign key(h_p_pnum) references h_product(h_p_num)
);
select * from h_p_image;

-- 핫딜 상품 카테고리
drop table h_category;
select * from h_category;
create table h_category (
	c_num int auto_increment primary key,
    c_name varchar(45) default '카테고리'
);
alter table h_category add constraint uq_c_name unique (c_name); -- 참조하는 컬럼에 PK가 지정되지 않았을때 인덱싱을 위하여 unique 지정

-- 핫딜 상품 카테고리 데이터 삽입
insert into h_category values (null, '디지털기기');
insert into h_category values (null, '생활가전');
insert into h_category values (null, '인테리어');
insert into h_category values (null, '카테고리 4');
insert into h_category values (null, '카테고리 5');
insert into h_category values (null, default);
select * from h_category;

-- 상품 목록(상품이미지와 텍스트를 같이 표시하는 목록)
select h_p_num, h_p_name, h_p_price, h_p_desc,
        h_p_orifilename, h_p_sysfilename
        from h_product left join h_p_image
        on h_p_num=h_p_pnum
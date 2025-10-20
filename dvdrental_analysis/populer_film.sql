/*********************************************************************************
 * ANALİZ ADI: Her Kategorinin En Popüler 2 Filmi (CTE + ROW_NUMBER Yöntemi)
 
 * KULLANILAN TEKNİKLER:
 * - CTE (WITH): Sorguyu mantıksal adımlara bölmek için.
 * - Çoklu JOIN ve GROUP BY: Her filmin toplam kiralama sayısını bulmak için.
 * - Window Function (ROW_NUMBER): Her kategori içinde filmleri sıralamak için.
 *********************************************************************************/

WITH film_kiralama_sayilari AS (
  SELECT
    F.title AS film_adi,
    C.name AS kategori_adi,
    COUNT(R.rental_id) AS kiralama_sayisi
  FROM
    rental AS R
    JOIN inventory AS I ON R.inventory_id = I.inventory_id
    JOIN film AS F ON I.film_id = F.film_id
    JOIN film_category AS FC ON F.film_id = FC.film_id
    JOIN category AS C ON FC.category_id = C.category_id
  GROUP BY
    F.film_id, C.name
),

-- Adım 2: Filmleri kendi kategorileri içinde sırala ve damgala
kategori_siralamasi AS (
  SELECT
    film_adi,
    kategori_adi,
    kiralama_sayisi,
    

    ROW_NUMBER() OVER (
      PARTITION BY kategori_adi
      ORDER BY kiralama_sayisi DESC
    ) AS siralama
  FROM
    film_kiralama_sayilari
)


SELECT
  kategori_adi,
  film_adi,
  kiralama_sayisi,
  siralama
FROM
  kategori_siralamasi
WHERE
  siralama <= 2
ORDER BY
  kategori_adi, siralama;
USE [Okul]

--Ilgili ogretmenin ilgili donemdeki dersini alan ogrenci sayisini veren fonksiyon:

ALTER FUNCTION [dbo].[FN$OgretmeninVerdigiDerseGoreOgrenciSayisi](@Ogretmen_Id int,@Ders_Id int,@Donem_Id int)
returns int
as
begin
declare @sonuc as int


set  @sonuc= (select count(*) as ogrencisayisi   from

(select o.Id as Ogretmen_Id, og.Id as Ogrenci_Id,(o.Adi+o.SoyAdi) as adsoyad, d.Id as Ders_Id, do.Id as Dönem_Id  from dbo.OgrenciOgretmenDers as ood
inner join dbo.OgretmenDers as od on od.Id=ood.OgretmenDers_Id and od.Statu=1
inner join dbo.Ogretmen as o on o.Id=od.Ogretmen_Id and o.Statu=1
inner join dbo.Ders as d on d.Id=od.Ders_Id and d.Statu=1
inner join dbo.Donem as do on do.Id=od.Donem_Id and do.Statu=1
inner join dbo.Ogrenci as og on og.Id=ood.Ogrenci_Id and og.statu=1
where 
od.Donem_Id=1
and 
ood.Statu=1
and d.Id=@Ders_Id
and do.Id=@Donem_Id
and o.Id=@Ogretmen_Id
group by o.Id,d.Id,do.Id,og.Id,o.Adi+o.SoyAdi)c

group by c.Ogretmen_Id, c.adsoyad,c.Dönem_Id 
)

return @sonuc
end






--calistiralim:
select [dbo].[FN$OgretmeninVerdigiDerseGoreOgrenciSayisi](6,8,1)






--where clause kontrolü:

--ogretmene gore dersi alan ogrenci sayısını vermektedir

	   
		select count(*) as ogrencisayisi ,c.Ogretmen_Id, c.Ders_Id,c.Dönem_Id  from

(select o.Id as Ogretmen_Id, og.Id as Ogrenci_Id,(o.Adi+o.SoyAdi) as adsoyad, d.Id as Ders_Id, do.Id as Dönem_Id  from dbo.OgrenciOgretmenDers as ood
inner join dbo.OgretmenDers as od on od.Id=ood.OgretmenDers_Id and od.Statu=1
inner join dbo.Ogretmen as o on o.Id=od.Ogretmen_Id and o.Statu=1
inner join dbo.Ders as d on d.Id=od.Ders_Id and d.Statu=1
inner join dbo.Donem as do on do.Id=od.Donem_Id and do.Statu=1
inner join dbo.Ogrenci as og on og.Id=ood.Ogrenci_Id and og.statu=1
where  ood.Statu=1
and od.Donem_Id=1
and d.Id=8
and o.Id=6
group by o.Id,d.Id,do.Id,og.Id,o.Adi+o.SoyAdi)c
group by c.Ogretmen_Id, c.adsoyad,c.Dönem_Id ,c.Ders_Id
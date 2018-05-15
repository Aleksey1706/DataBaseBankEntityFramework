/*
Шаблон скрипта после развертывания							
--------------------------------------------------------------------------------------
 В данном файле содержатся инструкции SQL, которые будут добавлены в скрипт построения.		
 Используйте синтаксис SQLCMD для включения файла в скрипт после развертывания.			
 Пример:      :r .\myfile.sql								
 Используйте синтаксис SQLCMD для создания ссылки на переменную в скрипте после развертывания.		
 Пример:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
INSERT INTO [dbo].[Addresses]([ClientID],[Country],[State],[City],[Address])VALUES('2','Ukraine','Khersonska oblast','Kherson','Stepana Razina,75'),
('3','Ukraine','Khersonska oblast','Kherson','Ushakova,23'),
('4','Ukraine','Khersonska oblast','Kherson','Kulika,123')
GO

INSERT INTO [dbo].[Clients] ([ClientID],[FirstName],[LastName],[Birthday],[Phone])
VALUES (1, '','', '1900-01-01','')
, (2,'Ivan','Ivanov', '1964-04-04','+380 (067) 111 11 11')
, (3,'Fedor','Fedorov', '1999-01-01','+380 (067) 222 11 11')	
, (4,'John','Smith', '1980-01-01','+380 (067) 333 33 33')
GO

INSERT INTO [dbo].[Cards] ([CardID], [ClientID], [PinCode])
VALUES 
('0000000000000000', 1, '0000')
, ('1111111111111111', 2, '1111'), ('1111111111111112', 2, '1112'), ('1111111111111113', 2, '1113')
, ('2222222222222221', 3, '2221'), ('2222222222222222', 3, '2222')
, ('3333333333333331', 4, '3331')
GO

INSERT INTO [dbo].[Operations] ([OutID],[InId],[Amount],[OperationTime])
VALUES 
('0000000000000000','1111111111111111', 1255.67)
, ('0000000000000000','2222222222222221', 100.00)
, ('0000000000000000','3333333333333331', 1000.00)
, ('1111111111111111','1111111111111112', 10.55)
, ('1111111111111111','1111111111111113', 1000.00)
, ('1111111111111111','2222222222222222', 33.00)
GO

with cteIn as 
(
	select InId as cardNo, debet = sum(Amount)
	from Operations
	group by InId
)
, cteOut as 
(
	select OutID as cardNo, kredit = sum(Amount)
	from Operations
	group by OutID
)
, cteBallance as
(
	select c.CadrID, newBallance = isnull(debet, 0) - isnull(kredit, 0)
	from Card c
		left join cteIn i on c.CadrID = i.cardNo
		left join cteOut o on c.CadrID = o.cardNo
)
update Card
set Ballance = newBallance
from Card inner join cteBallance on Card.CadrID = cteBallance.CadrID
GO


CREATE TABLE [dbo].[Operations](
	[OperationID] [int] NOT NULL,
	[InID] [char](16) NOT NULL,
	[OutID] [char](16) NOT NULL,
	[Amount] [money] NOT NULL,
	[OperationTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Operations] PRIMARY KEY CLUSTERED 
(
	[OperationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Operations]  WITH CHECK ADD  CONSTRAINT [FK_Operations_Card] FOREIGN KEY([InID])
REFERENCES [dbo].[Card] ([CadrID])
GO

ALTER TABLE [dbo].[Operations] CHECK CONSTRAINT [FK_Operations_Card]
GO
ALTER TABLE [dbo].[Operations]  WITH CHECK ADD  CONSTRAINT [FK_Operations_OUT] FOREIGN KEY([OutID])
REFERENCES [dbo].[Card] ([CadrID])
GO

ALTER TABLE [dbo].[Operations] CHECK CONSTRAINT [FK_Operations_OUT]
GO
ALTER TABLE [dbo].[Operations] ADD  CONSTRAINT [DF_Operations_OperationTime]  DEFAULT (getdate()) FOR [OperationTime]
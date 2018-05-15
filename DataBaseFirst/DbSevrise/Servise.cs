using System.Linq;
using DataBaseFirst;

namespace ReversePOCO.DbSevrise
{
    public class Servise { 

    public void RecalculateBallance(string cardNo)
    {
        using (var ctx = new Bank1Entities())
        {
            var card = ctx.Card.SingleOrDefault(c => c.CadrID == cardNo);
      

            ctx.Entry(card).Collection(c => c.Operations).Load();
            ctx.Entry(card).Collection(c => c.Operations1).Load();

            card.Ballance =
                card.Operations.Sum(o => o.Amount) - card.Operations1.Sum(o => o.Amount);

            ctx.SaveChanges();
        }
    }
}
}
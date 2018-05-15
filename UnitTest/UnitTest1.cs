using System;
using System.Linq;
using DataBaseFirst;

using Microsoft.VisualStudio.TestTools.UnitTesting;
using ReversePOCO.DbSevrise;

namespace UnitTest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
      public void TestRecalculateBallance()
            {
                var srv = new Servise();
                srv.RecalculateBallance("5111111111111111");
                srv.RecalculateBallance("5111111111111112");

                using (var ctx = new Bank1Entities())
                {
                    var card1 = ctx.Card.Single(c => c.CadrID == "5111111111111111");
                    var card2 = ctx.Card.Single(c => c.CadrID == "5111111111111112");

                    Assert.AreEqual(0, card1.Ballance + card2.Ballance);
                }
            }

       
    }
    }


package test;

import static org.junit.Assert.assertEquals;
import static org.junit.jupiter.api.Assertions.*;
import java.util.ArrayList;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import model.Asiakas;
import model.dao.Dao;
@TestMethodOrder(OrderAnnotation.class)
class JUnit_asiakastesti {

	@Test
	@Order(1)
	public void testPoistaKaikkiAsiakkaat() {
		//Poistetaan kaikki asiakkaat
		Dao dao = new Dao();
		dao.poistaKaikkiAsiakkaat("nimda");
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki();
		assertEquals(0, asiakkaat.size());
	}

	@Test
	@Order(2)
	public void testLisaaAsiakas() {
		Dao dao = new Dao();
		Asiakas asiakas_1 = new Asiakas(1345,"Anni","Meri","093840193","anni.m@gmail.com");
		Asiakas asiakas_2 = new Asiakas(2222,"Pekka","Lahtinen","23908420","p.lahtinen@hotmail.com");
		Asiakas asiakas_3 = new Asiakas(34533,"Tuukka","Järvinen","0298104","tuukka.jarvi@jarvinen.fi");
		Asiakas asiakas_4 = new Asiakas(43543,"Ilmo","Kantola","238792","ilmo.c@jippii.fi");
		assertEquals(true, dao.lisaaAsiakas(asiakas_1));
		assertEquals(true, dao.lisaaAsiakas(asiakas_2));
		assertEquals(true, dao.lisaaAsiakas(asiakas_3));
		assertEquals(true, dao.lisaaAsiakas(asiakas_4));
	}
	
	@Test
	@Order(3)
	public void testMuutaAsiakas() {
		Dao dao = new Dao();
		Asiakas muutettava = dao.etsiAsiakas(1);
		muutettava.setEtunimi("Kalle");
		muutettava.setSukunimi("Nieminen");
		muutettava.setPuhelin("12345");
		muutettava.setSposti("kalle@nieminen.fi");
		dao.muutaAsiakas(muutettava, "1");
		assertEquals("Kalle", dao.etsiAsiakas(1).getEtunimi());
		assertEquals("Nieminen", dao.etsiAsiakas(1).getSukunimi());
		assertEquals("12345", dao.etsiAsiakas(1).getPuhelin());
		assertEquals("kalle@nieminen.fi", dao.etsiAsiakas(1).getSposti());
	}
	@Test
	@Order(4)
	public void testPoistaAsiakas() {
		Dao dao = new Dao();
		dao.poistaAsiakas(1);
		assertEquals(null, dao.etsiAsiakas(1));
	}
}

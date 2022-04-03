## Resort_Data_Base
# Wstęp
Mój projekt dotyczy firmy, która zajmuje się wynajmem domków holenderskich. W tej bazie zależy mi na możliwości
szybkiego obliczenia kosztu pobytu, oraz szybkiego wynajmu domku. Wynajem domku oznacza wypełnienie tabeli „Pobyt”.
Do poprawnego umieszczenia gości w domkach są potrzebne informacje o liczbie sypialni i łóżek, a także o typie łóżek,
ponieważ nie wszystkie są przeznaczone dla wszystkich ze względu na ich długość, bądź wytrzymałość. Ponadto każdy
domek zawiera swój licznik energii i wody, kiedy goście przyjeżdżają stan obydwóch liczników zostaje spisany, aby obliczyć
ile goście zużyli tzw. mediów i ile będą musieli za to zapłacić. Kolejną istotną rzeczą są dane zbierane dla sanepidu
w związku z zaistniałą sytuacją dotyczącą COVID-19, znajdują się one w tabelce „Osoba”. Schemat niniejszej bazy jest
przedstawiony poniżej.
![image](https://user-images.githubusercontent.com/76752921/161445614-78dc9a3c-8f02-48fc-83d0-35e045809b2f.png)
# Założenia semantyczne
Warto zaznaczyć, że ta baza posiada założenie semantyczne, które można dostrzec pomiędzy tabelą „Domek” a „Pobyt”.
Mówi ono, że jeden pobyt dotyczy tylko jednego domku.

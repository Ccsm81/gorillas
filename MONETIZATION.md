# Gorillas — Plan de monetizare

Context: joc gratuit web/PWA, multiplayer P2P (fără server propriu), progresie locală,
distribuit prin link. Public: copii. ⇒ Monetizare **etică, non-pay-to-win, parent-friendly**.

## Opțiuni (ordonate după potrivire)

### 1. Cosmetice (RECOMANDAT) — nu dau avantaj în joc, deci e corect
- **Skin-uri de gorilă**: robot, dragon, extraterestru, ninja, unicorn, pirat.
- **Trail-uri / culori de proiectil**, efecte de victorie (confetti speciale), **planșe/teme exclusive**.
- Două monede:
  - **Coins (soft)** — câștigate din joc + misiuni (deja avem XP/misiuni → ușor de legat).
  - **Gems (hard)** — cumpărate cu bani reali, pentru cosmetice instant.
- Copiii cheltuie pe aspect, nu pe putere → corect + acceptat de părinți.

### 2. „Premium Pack" — o singură cumpărare (~$2.99)
- Deblochează TOATE armele instant (sari grind-ul) + toate skin-urile + o armă bonus exclusivă + XP dublu.
- Simplu, fără abonament, ușor de explicat părinților.

### 3. Battle-pass sezonier (mai târziu)
- Traseu de cosmetice câștigate jucând; track premium cu extra. Venit recurent, dar cere conținut constant.

### 4. Reclame — NU pentru copii
- Rewarded video (vezi reclamă → +coins) e singura formă kid-friendly, dar rețelele de reclame sub-13 sunt restricționate (COPPA/GDPR-K). De evitat la publicul ăsta.

## Partea grea: încasarea pe un PWA
Un PWA NU poate folosi billing-ul App Store (ăla cere app nativ). Variante:
- **Cod de deblocare (cel mai simplu START, fără backend):** vinzi un cod prin **Lemon Squeezy / Gumroad**
  (ei gestionează plata + TVA-ul). Cumpărătorul plătește, primește un cod, îl introduce în joc → se deblochează Premium.
- **Web payments (Stripe/Paddle) + backend mic** (Cloudflare Workers / Netlify Functions) care verifică plata
  și ține „entitlement"-ul legat de un login sau cod. Mai mult de lucru.
- **Dacă scoți și app nativ** (Capacitor iOS/Android): folosești **IAP din App Store / Play** — cel mai de încredere,
  dar cere build nativ + conturi developer ($99/an Apple, $25 o dată Google).

## Calea recomandată (friction minim, începi să încasezi repede)
1. **Faza 1** (pot construi eu): sistem de cosmetice (skin-uri + trail-uri) + monedă soft câștigată. Gratis.
2. **Faza 2**: vinzi un **„Premium Pack" prin Lemon Squeezy/Gumroad** (fără backend) → cod care deblochează totul.
   Eu construiesc ecranul „introdu codul" + logica de deblocare. **Tu** faci contul de vânzător + setezi prețul.
3. **Faza 3** (dacă prinde): wrapper nativ + IAP App Store/Play pentru gems/cosmetice.

## Reguli etice (obligatoriu la copii)
- Fără timere manipulatoare, fără loot-boxes cu bani reali, prețuri clare o-singură-dată.
- **Parent-gate** pe ecranul de cumpărare (o întrebare de matematică simplă înainte de plată — standard în appurile pt copii).

## Ce pot / NU pot face eu
- ✅ Pot construi: sistemul de cosmetice, monedă soft, ecranul „introdu cod", logica de entitlement, parent-gate.
- ❌ NU pot: să-ți creez contul de vânzător, să introduc date de plată sau să configurez procesatorul de plăți — alea le faci tu
  (Lemon Squeezy/Gumroad/Stripe), apoi eu conectez redempția codului.

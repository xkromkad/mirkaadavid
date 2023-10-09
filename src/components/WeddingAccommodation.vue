<template>
  <div class="nameText q-mb-md" :style="{ fontSize: fontSize + 'px' }">
    Ubytovanie
  </div>
  <div class="text text-center q-my-lg q-mb-xl">
    Keďže sa svadobná hostina koná v Ždiari, je pre vás zabezpečený odvoz
    autobusom zo Ždiaru do Popradu okolo 4:00 ráno. <br />
    <br />
    Ak by ste sa rozhodli prenocovať v Ždiari, hotel, v ktorom sa svadba koná,
    poskytuje ubytovanie. Je však potrebné, aby ste si ho vopred rezervovali.
    <br />
    <br />
    Pri rezervácii nezabudnite povedať, že ste svadobní hostia. Budete mať
    zvýhodnenú cenu.
    <br />
    <br />
    <a href="https://www.magurahotel.sk" target="_blank">Hotel Magura Ždiar</a>

    <br />
    <a href="tel:+421524780511">Telefón: +421 52 478 05 11</a>

    <br />
    <a href="tel:+421911887385">Mobil: +421 911 887 385</a>

    <br />
    <a href="mailto:recepcia@magurahotel.sk">Mail: recepcia@magurahotel.sk</a>
  </div>
</template>

<script lang="ts">
import { inject } from 'vue';
export default {
  name: 'WeddingAccommodation',
  setup() {
    const fontSize = inject('fontSize');
    return { fontSize };
  },
};
</script>

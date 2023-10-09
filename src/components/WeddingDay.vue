<template>
  <div class="nameText" :style="{ fontSize: fontSize + 'px' }">
    Svadobný deň
  </div>
  <div class="nameText" :style="{ fontSize: fontSize - 15 + 'px' }">
    30. september 2023
  </div>
  <div class="text text-center q-my-lg q-mb-xl">
    Svoje áno si povieme v Konkatedrále Sedembolestnej Panny Márie v Poprade o
    15:00. Zabezpečený bude autobus, ktorý pôjde o 14:00 od ženícha ku neveste,
    kde bude odpytávanie, pripínanie pierok, dostanete stužku na auto a iste sa
    vám újde aj po poháriku.
    <br />
    Po obrade sa všetci pozvaní presunú do Ždiaru, kde bude následovať zábava.
    Autobus pôjde od kostola do Ždiaru. Môžete sa tešiť na skvelé jedlo a dobrú
    náladu. Autobus je zabezpečený aj nadránom zo Ždiaru do Popradu.
    <br />
    <br />
    Veľmi sa na vás všetkých tešíme.
  </div>
</template>

<script>
import { inject } from 'vue';
export default {
  name: 'WeddingDay',
  setup() {
    const fontSize = inject('fontSize');
    return { fontSize };
  },
};
</script>

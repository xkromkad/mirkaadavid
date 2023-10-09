<template>
  <div class="nameText q-mb-md" :style="{ fontSize: fontSize + 'px' }">
    My dvaja
  </div>
  <div class="text text-center q-my-lg q-mb-xl">
    Nevesta a ženích <br />
    Mirka a Dávid <br />
    <br />
    Ľúbime chlebík a seba navzájom.
    <br /><br />
    30.9.2018 sa začala naša spoločná cesta a stal sa z nás pár. Dnes, 30.9.2023
    sa z nás po 5 rokoch vzťahu stanú manželia. Zaspomínajte si spolu s nami,
    ako sme rástli a ako sme sa našli.
    <br />
  </div>
  <div class="row text-center q-mb-lg">
    <div
      v-for="(url, index) in imageUrls"
      :key="index"
      class="col-md-6 col-sm-12 col-12 q-pa-sm"
    >
      <div v-if="index % 2 === 0" class="text text-center" style="height: 30px">
        {{ year + index / 2 }}
      </div>
      <div
        v-if="index % 2 === 1"
        class="text text-center"
        style="height: 30px"
      ></div>
      <q-img
        class="cursor-pointer q-hoverable"
        v-ripple
        @click="setModel(url)"
        :src="url"
        style="max-width: 400px"
      />
    </div>
  </div>

  <q-dialog v-model="carousel">
    <q-carousel
      infinite
      transition-prev="slide-right"
      transition-next="slide-left"
      swipeable
      animated
      v-model="slide"
      control-color="primary"
      padding
      arrows
      fullscreen
      class="bg-white shadow-1 rounded-borders"
    >
      <q-carousel-slide
        :name="url"
        class="column no-wrap flex-center"
        v-for="(url, index) in imageUrls"
        :key="index"
      >
        <div class="row full-width">
          <q-space />
          <q-btn icon="close" flat round dense @click="carousel = false" />
        </div>

        <q-img :src="url" style="max-width: 900px" />
      </q-carousel-slide>
    </q-carousel>
  </q-dialog>
</template>

<script lang="ts">
import { inject, ref } from 'vue';
export default {
  name: 'AboutUs',
  setup() {
    const fontSize = inject('fontSize');
    const year = ref(2018);
    const imageUrls = [
      'src/assets/grow_up/2018_1.jpg',
      'src/assets/grow_up/2018_2.jpg',
      'src/assets/grow_up/2019_1.jpg',
      'src/assets/grow_up/2019_2.jpeg',
      'src/assets/grow_up/2020_1.jpg',
      'src/assets/grow_up/2020_2.jpg',
      'src/assets/grow_up/2021_1.jpg',
      'src/assets/grow_up/2021_2.jpeg',
      'src/assets/grow_up/2022_1.jpg',
      'src/assets/grow_up/2022_2.jpg',
      'src/assets/grow_up/2023_1.jpg',
      'src/assets/grow_up/2023_2.jpg',
    ];
    const slide = ref(imageUrls[1]);
    const carousel = ref(false);

    function setModel(url: string) {
      slide.value = url;
      carousel.value = true;
    }
    return {
      slide,
      carousel,
      fontSize,
      year,
      imageUrls,
      setModel,
    };
  },
};
</script>

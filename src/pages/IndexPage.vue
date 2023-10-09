<template>
  <q-page class="items-center justify-center">
    <div class="image-container" v-if="tab != 'us'">
      <q-img
        class="move-out"
        :src="imgAnnouncement"
        style="width: 100%"
      ></q-img>
    </div>
    <div class="image-container" v-if="tab == 'us'">
      <q-img class="move-out" :src="imgMirka" style="width: 50%"></q-img>
      <q-img class="move-out" :src="imgDavid" style="width: 50%"></q-img>
      <!--<q-img :src="'src/assets/oznamenie.jpg'" style="width: 100%"></q-img>-->
      <div
        class="centered-text full-width move-out"
        :style="{ fontSize: fontSize + 'px', top: imgTop + '%' }"
      >
        My dvaja <br />
        sa berieme
        <countdown-timer />
      </div>
    </div>
    <q-toolbar class="toolbar">
      <q-space></q-space>
      <q-btn
        :icon="'img:src/assets/camera.png'"
        class="cameraIcon"
        flat
        @click="setTab('images')"
      />
    </q-toolbar>
    <q-toolbar class="menu row items-center justify-center q-pa-xs">
      <div class="row justify-center">
        <q-btn
          v-for="t in tabs"
          :key="t.key"
          :style="{
            backgroundColor: tab === t.key ? 'rgb(246, 204, 36)' : '',
          }"
          :label="t.label"
          flat
          @click="setTab(t.key)"
        />
      </div>
    </q-toolbar>
    <div class="row items-center justify-center">
      <div class="col-12 col-sm-6 q-px-sm">
        <div class="row items-center justify-center">
          <q-img
            :src="'src/assets/kvety.png'"
            style="width: 100%; max-width: 50rem"
          ></q-img>
        </div>
        <div :id="tab">
          <component :is="tabComponents[tab]" />
        </div>
      </div>
    </div>
  </q-page>
</template>

<script lang="ts">
import { defineComponent, provide, onMounted, ref, onBeforeUnmount } from 'vue';
import CountdownTimer from 'src/components/CountdownTimer.vue';
import AboutUs from 'src/components/AboutUs.vue';
import WeddingDay from 'src/components/WeddingDay.vue';
import WeddingGifts from 'src/components/WeddingGifts.vue';
import WeddingAccommodation from 'src/components/WeddingAccommodation.vue';
import CContacts from 'src/components/CContacts.vue';
import CImages from 'src/components/CImages.vue';

export default defineComponent({
  name: 'IndexPage',
  components: {
    CountdownTimer,
    AboutUs,
    WeddingDay,
    WeddingGifts,
    WeddingAccommodation,
    CContacts,
    CImages,
  },
  setup() {
    const imgMirka = ref('src/assets/chlieb/mirka.jpg');
    const imgDavid = ref('src/assets/chlieb/david.jpg');
    const imgAnnouncement = ref('src/assets/oznamenie_lg.jpg');
    const fontSize = ref(50);
    const imgTop = ref(50);
    const isFlowersVisible = ref(true);
    const tab = ref('us');

    const tabs = [
      { key: 'us', label: 'My dvaja' },
      { key: 'day', label: 'Svadobný deň' },
      { key: 'images', label: 'Fotky' },
      { key: 'gifts', label: 'Dary' },
      { key: 'accommodation', label: 'Ubytovanie' },
      { key: 'contact', label: 'Kontakt' },
    ];

    provide('fontSize', fontSize);

    const setTab = (tabValue: string) => {
      if (!tabs.some((tab) => tab.key === tabValue)) {
        tabValue = 'us';
      }
      tab.value = tabValue;

      const newUrl = `/${tabValue}`;
      window.history.pushState({}, '', newUrl);

      if (tab.value) {
        import('vue').then(({ nextTick }) => {
          nextTick().then(() => {
            scrollToElement();
          });
        });
      }
    };

    const scrollToElement = () => {
      const target = document.getElementById(tab.value);
      if (target) {
        target.scrollIntoView({ behavior: 'smooth' });
      }
    };

    const updateImageSources = () => {
      if (window.innerWidth <= 1000) {
        imgAnnouncement.value = 'src/assets/oznamenie.jpg';
        imgMirka.value = 'src/assets/chlieb_small/mirka.jpg';
        imgDavid.value = 'src/assets/chlieb_small/david.jpg';
        fontSize.value = 40;
        imgTop.value = 70;
        isFlowersVisible.value = true;
      }
      if (window.innerWidth <= 600) {
        imgAnnouncement.value = 'src/assets/oznamenie.jpg';
        imgMirka.value = 'src/assets/chlieb_xs/mirka.jpg';
        imgDavid.value = 'src/assets/chlieb_xs/david.jpg';
        fontSize.value = 35;
        isFlowersVisible.value = false;
      } else {
        imgAnnouncement.value = 'src/assets/oznamenie_lg.jpg';
        imgMirka.value = 'src/assets/chlieb/mirka.jpg';
        imgDavid.value = 'src/assets/chlieb/david.jpg';
        fontSize.value = 50;
      }
    };

    onMounted(() => {
      // Get the current URL path
      const currentPath = window.location.pathname;

      // Extract the tabValue from the URL
      const tabValue = currentPath.slice(1); // Remove the leading '/'

      // Set the tabValue in your component's state
      setTab(tabValue);

      updateImageSources();
      window.addEventListener('resize', updateImageSources);
    });

    onBeforeUnmount(() => {
      window.removeEventListener('resize', updateImageSources);
    });

    const tabComponents: Record<string, string> = {
      us: 'about-us',
      day: 'wedding-day',
      gifts: 'wedding-gifts',
      accommodation: 'wedding-accommodation',
      contact: 'c-contacts',
      images: 'c-images',
    };
    return {
      zoom: 2,
      imgMirka,
      imgDavid,
      imgAnnouncement,
      fontSize,
      imgTop,
      isFlowersVisible,
      tab,
      tabs,
      tabComponents,
      setTab,
    };
  },
});
</script>

<style src="assets/styles/indexPage.scss"></style>

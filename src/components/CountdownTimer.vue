<template>
  <div class="row items-center justify-center">
    <p class="timerText" v-if="seconds >= 0">
      {{ days }} d {{ hours }} h {{ minutes }} m {{ seconds }} s
    </p>
    <p v-if="seconds < 0">Sme svoji!</p>
  </div>
</template>

<script>
import { ref, computed } from 'vue';

export default {
  name: 'CountdownTimer',
  setup() {
    const targetDate = new Date('2023-09-30T15:00:00');
    const currentDate = ref(new Date());

    const timeRemaining = computed(() => targetDate - currentDate.value);

    const days = computed(() =>
      Math.floor(timeRemaining.value / (1000 * 60 * 60 * 24))
    );
    const hours = computed(() =>
      Math.floor(
        (timeRemaining.value % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
      )
    );
    const minutes = computed(() =>
      Math.floor((timeRemaining.value % (1000 * 60 * 60)) / (1000 * 60))
    );
    const seconds = computed(() =>
      Math.floor((timeRemaining.value % (1000 * 60)) / 1000)
    );

    setInterval(() => {
      currentDate.value = new Date();
    }, 1000);

    return {
      days,
      hours,
      minutes,
      seconds,
    };
  },
};
</script>

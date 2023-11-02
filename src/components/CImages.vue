<template>
  <div class="nameText q-mb-md" :style="{ fontSize: fontSize + 'px' }">
    Fotky
  </div>
  <div class="text text-center q-my-lg">
    Zdieľajte s nami momenty z našej svadby zachytené vašim fotoaparátom.
  </div>

  <div class="q-pa-md column items-start q-gutter-y-md q-mb-xl">
    <q-file
      :model-value="files"
      @update:model-value="updateFiles"
      label="Vyberte súbory"
      accept="image/*,video/*"
      outlined
      multiple
      :clearable="!isUploading"
      class="fit"
    >
      <template v-slot:file="{ index, file }">
        <q-chip
          class="full-width q-my-xs"
          :removable="isUploading && uploadProgress[index].percent < 1"
          square
          @remove="cancelFile(index)"
        >
          <q-linear-progress
            class="absolute-full full-height"
            :value="uploadProgress[index].percent"
            :color="uploadProgress[index].color"
            track-color="grey-2"
          />

          <q-avatar>
            <q-icon :name="uploadProgress[index].icon" />
          </q-avatar>

          <div class="ellipsis relative-position">
            {{ file.name }}
          </div>

          <q-tooltip>
            {{ file.name }}
          </q-tooltip>
        </q-chip>
      </template>

      <template v-slot:after v-if="canUpload">
        <q-btn
          color="primary"
          dense
          icon="cloud_upload"
          round
          @click="upload"
          :disable="!canUpload"
          :loading="isUploading"
        />
      </template>
    </q-file>
  </div>

  <div class="row text-center q-mb-lg">
    <div
      v-for="url in imageUrls"
      :key="url"
      class="col-md-6 col-sm-12 col-12 q-pa-sm"
    >
      <q-img loading="lazy" :src="url" style="max-width: 400px" />
    </div>
  </div>
</template>

<script>
import { ref, onBeforeUnmount, computed, inject, onMounted } from 'vue';
import {
  getStorage,
  ref as storageRef,
  uploadBytes,
  listAll,
  getDownloadURL,
} from 'firebase/storage';
import { useQuasar } from 'quasar';
import firebaseApp from 'src/firebase'; // Adjust the path based on your project structure

export default {
  name: 'CImages',
  props: {
    maxLength: {
      type: Number,
      default: 20,
    },
  },
  setup() {
    const $q = useQuasar();
    const fontSize = inject('fontSize');
    const uploadedImages = ref([]);
    const imageUrls = ref([]);

    const files = ref(null);
    const uploadProgress = ref([]);
    const uploading = ref(null);

    function cleanUp() {
      clearTimeout(uploading.value);
    }

    onMounted(async () => {
      // Initialize Firebase Storage
      const storage = getStorage();

      // Fetch the list of all files in the 'products' directory
      const storRef = storageRef(storage, 'products');

      const fileList = await listAll(storRef);

      // Fetch the download URL for each file and add it to the imageUrls array
      for (const file of fileList.items) {
        try {
          const downloadURL = await getDownloadURL(file);
          imageUrls.value.push(downloadURL);
        } catch (error) {
          console.error('Error fetching download URL:', error);
        }
      }
    });

    async function updateUploadProgress() {
      const storage = getStorage();

      for (let index = 0; index < uploadProgress.value.length; index++) {
        const progress = uploadProgress.value[index];
        const file = files.value[index];
        const fileRef = storageRef(storage, 'products/' + file.name);

        if (progress.percent === 1 || progress.error === true) {
          continue;
        }

        var percent = 0;
        var error = false;

        try {
          await uploadBytes(fileRef, file);
          console.log(`${file.name} uploaded`);
          percent = 1; // Mark as completed
        } catch (error) {
          percent = 0.5;
          console.error(`Error uploading ${file.name}:`, error);
          done = false; // Mark as not done due to error
        }

        uploadProgress.value[index] = {
          ...progress,
          error,
          color: error === true ? 'red-2' : 'green-2',
          percent,
        };
      }
    }

    onBeforeUnmount(cleanUp);

    return {
      fontSize,
      uploadedImages,
      files,
      uploadProgress,
      uploading,
      imageUrls,

      isUploading: computed(() => uploading.value !== null),
      canUpload: computed(() => files.value !== null),

      cancelFile(index) {
        this.uploadProgress[index] = {
          ...this.uploadProgress[index],
          error: true,
          color: 'orange-2',
        };
      },

      updateFiles(newFiles) {
        files.value = newFiles;
        uploadProgress.value = (newFiles || []).map((file) => ({
          error: false,
          color: 'green-2',
          percent: 0,
          icon:
            file.type.indexOf('video/') === 0
              ? 'movie'
              : file.type.indexOf('image/') === 0
              ? 'photo'
              : 'insert_drive_file',
        }));
      },

      async upload() {
        cleanUp();

        const allDone = uploadProgress.value.every(
          (progress) => progress.percent === 1
        );

        uploadProgress.value = uploadProgress.value.map((progress) => ({
          ...progress,
          error: false,
          color: 'green-2',
          percent: allDone === true ? 0 : progress.percent,
        }));

        await updateUploadProgress();

        const allUploaded = uploadProgress.value.every(
          (progress) => progress.percent === 1
        );
        if (allUploaded) {
          setTimeout(function () {
            files.value = null;
            $q.notify({
              type: 'positive',
              message: 'Súbory boli úspešne odoslané.',
              timeout: 3500,
              position: 'center',
            });
          }, 1500);
        }
      },
    };
  },
};
</script>

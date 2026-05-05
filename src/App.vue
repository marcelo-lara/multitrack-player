<template>
  <div>
    <VProgressLinear v-if="$store.state.loading" indeterminate />
    <VApp v-else>
      <VSnackbar v-model="midiNoticeVisible" :timeout="8000" color="warning">
        {{ midiNotice }}
        <template #action="{ attrs }">
          <VBtn text v-bind="attrs" @click="midiNoticeVisible = false">
            Dismiss
          </VBtn>
        </template>
      </VSnackbar>

      <VAppBar height="auto" class="app-bar">
        <v-toolbar-title class="headline d-none d-md-flex">
          Multitrack Player
        </v-toolbar-title>
        <Controls />
      </VAppBar>

      <v-content>
        <router-view />
      </v-content>
    </VApp>
  </div>
</template>

<script>
import Controls from '@/components/Controls';

import { initClick } from './click';
import { initMidi } from './midi';
import { initKeyEvents } from './key';

export default {
  components: {
    Controls
  },
  data() {
    return {
      midiNotice: '',
      midiNoticeVisible: false
    };
  },
  async mounted() {
    await Promise.all([
      initMidi().catch(error => {
        this.midiNotice = this.getMidiNotice(error);
        this.midiNoticeVisible = true;
      }),
      initClick()
    ]);
    await this.$store.dispatch('initSettings');
    initKeyEvents(this.$store);

    this.$store.commit('setLoading', false);
  },
  watch: {
    '$store.state.controlEditMode'(value) {
      this.$vuetify.theme.dark = !!value;
    }
  },
  methods: {
    getMidiNotice(error) {
      if (error && error.name === 'NotAllowedError') {
        return 'MIDI controls are unavailable because browser permission was denied.';
      }

      return 'MIDI controls are unavailable in this browser session.';
    }
  }
};
</script>

<style lang="scss" scoped>
.app-bar {
  flex-grow: 0;
}
</style>

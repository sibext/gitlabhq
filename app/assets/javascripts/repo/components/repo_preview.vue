<script>
/* global LineHighlighter */

import Store from '../stores/repo_store';

export default {
  data() {
    return Store;
  },
  computed: {
    html() {
      return this.activeFile.html;
    },
  },
  methods: {
    highlightFile() {
      $(this.$el).find('.file-content').syntaxHighlight();
    },
    highlightLine() {
      if (Store.activeLine > -1) {
        this.lineHighlighter.highlightHash(`#L${Store.activeLine}`);
      }
    },
  },
  mounted() {
    this.highlightFile();
    this.lineHighlighter = new LineHighlighter({
      fileHolderSelector: '.blob-viewer-container',
      scrollFileHolder: true,
    });
  },
  watch: {
    html() {
      this.$nextTick(() => {
        this.highlightFile();
        this.highlightLine();
      });
    },
    activeLine() {
      this.highlightLine();
    },
  },
};
</script>

<template>
<div>
  <div
    v-if="!activeFile.render_error"
    v-html="activeFile.html">
  </div>
  <div
    v-else-if="activeFile.tooLarge"
    class="vertical-center render-error">
    <p class="text-center">
      The source could not be displayed because it is too large. You can <a :href="activeFile.raw_path">download</a> it instead.
    </p>
  </div>
  <div
    v-else
    class="vertical-center render-error">
    <p class="text-center">
      The source could not be displayed because a rendering error occurred. You can <a :href="activeFile.raw_path">download</a> it instead.
    </p>
  </div>
</div>
</template>

<template>
  <div>
    <p>現在の戦況は以下の通りです。</p>
    <p>東軍</p>
    <p>{{ battleInfo[0].east }}</p>
    <p>西軍</p>
    <p>{{ battleInfo[0].west }}</p>
    <p>{{ battleInfo[0].user_name }}殿の功績</p>
    <p>{{ battleInfo[0].user_battle }}</p>
    <p>{{ battleInfo[0].user_name }}殿は</p>
    <p>{{ battleInfo[0].belong }}軍です。</p>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()
export default {
  data() {
    return {
      battleInfo:{}
    }
  },

  computed: {


    isLiked() {
      if (this.battleInfo.length === 0) { return false }
      return Boolean(this.findLikeId())
    }
  },

  created: function() {
    this.fetchLikeByPostId().then(result => {
      this.battleInfo = result
    })
  },
  methods: {

    fetchLikeByPostId: async function() {
      const res = await axios.get(` /api/combat/index`)
      if (res.status !== 200) { process.exit() }
      return res.data
    },

    registerLike: async function() {
      const res = await axios.post('/api/combat/create')
      if (res.status !== 201) { process.exit() }
      this.fetchLikeByPostId().then(result => {
        this.likeList = result
      })
    },

    findLikeId: function() {
      const like = this.likeList.find((like) => {
        return (like.user_id === this.userId)
      })
      if (like) { return like.id }
    }
  }
}
</script>

<style scoped>

</style>
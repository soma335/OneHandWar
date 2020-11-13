<template>
  <div>
    <p>現在の戦況は以下の通りです。</p>
    <p>東軍</p>
    <span v-for="battle in combat" v-bind:key="battle.battle_record">
    <p>{{ battle.east }}</p>
    <p>西軍</p>
    <p>{{ battle.west }}</p>
    <p>{{ battle.user_name }}殿の功績は</p>
    <p>{{ battle.battle_record }}です。</p>
    <p>{{ battle.user_name }}殿は</p>
    <p>{{ battle.belong }}軍です。</p>
    <p @click="Sword()">
      剣を使う
    </p>
    <p @click="Bow()">
      弓を使う
    </p>
    </span>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()
export default {
  data() {
    return {
      combat:{
        battle_record: ''
      }
    }
  },

  watch:{
    battle_record(){
      this.fetchLikeByPostId().then(result => {
        this.combat = result.data
      })
    }
  },

  created: function() {
    this.fetchLikeByPostId().then(result => {
      this.combat = result.data
    })
   },
  methods: {
    modelSave: async function () {
      const res = await axios.post('/api/combats', {battle_record: this.combat[0].battle_record} )
      if (res.status !== 201) {
        console.log('bug');
        process.exit()
      }
    },

    Sword: async function () {
      this.combat[0].battle_record ++
      this.modelSave().then(result => {
        return result
      })
    },
    Bow: async function () {
      this.combat[0].battle_record ++
      this.modelSave().then(result => {
        return result
      })
    },

    fetchLikeByPostId: async function() {
      const res = await axios.get(` /api/combats`)
      if (res.status !== 200) { process.exit() }
      return res
    },
  }
}
</script>

<style scoped>

</style>
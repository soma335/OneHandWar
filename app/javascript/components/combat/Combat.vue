<template>
  <div>
    <p>現在の戦況は以下の通りです。</p>
    <p>東軍</p>
    <p>{{ combat.east_strength }}</p>
    <p>西軍</p>
    <p>{{ combat.west_strength }}</p>
    <p>{{ combat.user_name | replace }}殿の功績は</p>
    <p>{{ combat.battle_record }}です。</p>
    <p>{{ combat.user_name | replace }}殿は</p>
    <p>{{ combat.belong | replace }}軍です。</p>
    <p @click="Sword()">
      剣を使う
    </p>
    <p @click="Bow()">
      弓を使う
    </p>
  </div>
</template>

<script>
import axios from 'axios'
import {csrfToken} from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()
export default {
  data() {
    return {
      combat: {}
    }
  },

  created: function () { //サーバからJsonデータを受信し、配列の最初の値をデータオブジェクトに格納
    this.modelGet().then(response => {
      this.combat = response.data.shift();
    })
  },

  filters: { //カスタムフィルタ(Json形式だとダブルクオーテーションがつく為viewでは消す。)
    replace: function (val) {
      if (!val) {
        return val;
      }
      return val.replace(/[¥"]/g, "").replace(/east/g, '東')
          .replace(/west/g, '西');
    }
  },

  methods: {
    modelSave: async function () {
      const res = await axios.post('/api/combats', {battle_record: this.combat.battle_record})
      if (res.status !== 201) {
        process.exit()
      }
      this.modelGet().then(response => {
        this.combat = response.data.shift();
      })
    },
    Sword: async function () {
      this.combat.battle_record++
      await this.modelSave()
    },
    Bow: async function () {
      this.combat.battle_record++
      this.modelSave().then(result => {
        return result
      })
    },
    modelGet: async function () {
      const res = await axios.get(` /api/combats`)
      if (res.status !== 200) {
        process.exit()
      }
      return res
    },

  }
}
</script>

<style scoped>

</style>
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
    <div class="btn_all">
      <button @click="Sword()">剣を使う</button>
      <button @click="Bow()">弓を使う</button>
      <button @click="Gun()">銃を使う</button>
    </div>
    <p v-if="gun_flag">{{ readyToFire }}秒後に銃を使うボタンを押してください。</p>
    <Loading v-show="loading"></Loading>

  </div>
</template>

<script>
import axios from 'axios'
import {csrfToken} from 'rails-ujs'
import Loading from '../Loading.vue'

axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()
export default {
  data() {
    return {
      combat: {
        battle_record: ''
      },
      loading: false,
      readyToFire: '',
      start: '',
      timer: '',
      interval: '',
      accum: '',
      gun_flag: false
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

  components: {
    Loading,
  },

  methods: {
    reset: () => {
      Object.assign(app.$data, app.$options.data());
    },

   sleep: function(sec){
      return new Promise(function(resolve) {
        setTimeout(function() {resolve()}, sec);
      })
    },

    modelSave: async function () {
      const res = await axios.post('/api/combats', {combat: this.combat})
      if (res.status !== 201) {
        process.exit()
      }
      await this.sleep(2000);
      this.modelGet().then(response => {
        this.combat.reset
        this.combat = response.data.shift();
      })
      this.loading = false;
    },
    Sword: async function () {
      this.loading = true;
      this.combat.battle_record++
      await this.modelSave()
    },
    Bow: async function () {
      alert('現在作成中です')
    },
    Gun: async function () {
      if (this.gun_flag == true) {
        this.gun_flag = false
        this.elapsedTime = (Date.now() - this.start) / 1000;
        this.result = this.elapsedTime.toFixed(3);
        this.diff = this.result - this.readyToFire;
        alert(this.diff)
        if (this.diff < -1.0) {
          alert("発砲できませんでした・・・。")
          alert(Math.abs(this.diff).toFixed(2) + "秒早いです。")
        } else if (this.diff > 1.0) {
          alert("発砲できませんでした・・・。")
          alert(Math.abs(this.diff).toFixed(2) + "秒遅いです。")
        } else {
          alert("発砲成功!")
          this.combat.battle_record = Number(this.combat.battle_record) + 50;
          await this.modelSave()
        }
      } else {
        this.gun_flag = true;
        const min = 2;
        const max = 11;
        this.readyToFire = Math.floor(Math.random() * (max + 1 - min)) + min / 100;
        this.start = Date.now();
      }
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
.button_all {
  text-align: center;
}

button {
  padding: 0.5em 1em;
  text-decoration: none;
  background: #715454;
  border-bottom: solid 4px #627295;
  border-radius: 3px;
  color: #D2D0E8;
}

button:active {
  -webkit-transform: translateY(4px);
  transform: translateY(4px); /*下に動く*/
  border-bottom: none; /*線を消す*/
}

</style>
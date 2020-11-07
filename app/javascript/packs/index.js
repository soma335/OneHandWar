import 'babel-polyfill'
import Vue from 'vue'

// 作成したコンポーネントファイルをimportします
import Combat from '../components/combat/Combat.vue'

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        el: '#combats',
        components: { Combat }
    })
})
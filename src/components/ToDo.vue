<template>
  <section id='todo'>
    <h1>ToDo</h1>

    <div v-if="defaultAccount">
      <button @click="read()">Reload</button>

      <ul>
        <li v-for="(item, index) in items">
          {{ $web3.utils.hexToUtf8(item) }}
          <a @click="destroy($event, index)" href="#">x</a>
        </li>
      </ul>

      <form>
        <input v-model="item"/>
        <button @click="create($event)">Create</button>
      </form>
    </div>
    <div v-else>Make sure MetaMask is installed and unlocked</div>
  </section>
</template>

<script>
  import ToDoArtifact from '@contracts/ToDo.json'

  export default {
    name: 'todo',
    data () {
      return {
        contracts: {},
        items: [],
        item: '',
        defaultAccount: null,
        gasPrice: '5'
      }
    },
    created: async function () {
      const accounts = await this.$web3.eth.getAccounts()
      this.defaultAccount = accounts[0]
      this.$web3.eth.defaultAccount = accounts[0]

      const networkId = await this.$web3.eth.net.getId()
      this.contracts.ToDo = new this.$web3.eth.Contract(ToDoArtifact.abi, ToDoArtifact.networks[networkId].address)
      this.read()
    },
    methods: {
      create: function (e) {
        e.preventDefault()
        console.log(this.$web3.eth.defaultAccount)
        this.contracts.ToDo.methods.create(this.$web3.utils.utf8ToHex(this.item)).send({
          from: this.$web3.eth.defaultAccount,
          gasPrice: this.$web3.utils.toWei(this.gasPrice, 'gwei')
        }).then(() => {
          this.read()
        }).catch(() => {})
      },
      read: function () {
        const gas = Math.floor(Math.random() * 50000) + 30000
        this.contracts.ToDo.methods.read().call({
          gas: gas
        }).then(items => {
          this.items = items
        }).catch(() => {})
      },
      destroy: function (e, id) {
        e.preventDefault()
        this.contracts.ToDo.methods.destroy(id).send({
          from: this.$web3.eth.defaultAccount,
          gasPrice: this.$web3.utils.toWei(this.gasPrice, 'gwei'),
          gas: 50000
        }).then(receipt => {
          console.log(receipt)
          this.read()
        }).catch(() => {})
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>

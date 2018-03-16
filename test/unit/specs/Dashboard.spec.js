import Vue from 'vue'
import ToDo from '@/components/ToDo'
import router from '@/router'

describe('ToDo.vue', () => {
  it('should render correct contents', () => {
    const Constructor = Vue.extend(ToDo)
    const vm = new Constructor({router}).$mount()
    expect(vm.$el.querySelector('#todo h1').textContent)
      .to.equal('ToDo')
  })
})

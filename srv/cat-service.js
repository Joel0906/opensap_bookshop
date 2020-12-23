const cds = require('@sap/cds')
const { Books } = cds.entities

/* Service Implementation of catalog service */
module.exports = cds.service.impl(srv => {
    srv.after('READ', 'Books', each => each.stock > 111 && _addDiscount2(each, 11))
    srv.before('CREATE', 'Orders', _reduceStock)
})

/* Add some discount for over stocked books */
function _addDiscount2(each, discount) {
    each.title = each.title + ` -- ${discount}%  discount!`
}

/** Reduce stock of ordered books if available stock suffice**/
function _reduceStock(req) {
    const { items: orderItems } = req.data  

    const tx = cds.transaction(req)
    const updatedBooks = orderItems.map(item => {
        updateBooks(item)
    })

    async function updateBooks(item) {
        const a = tx.update(Books).set('stock -=', item.amount).where('ID =', item.book_ID).and('stock >=', item.amount)
        const b = await tx.run(a)
        if (b === 0){
            req.error(409, `${item.amount} exceeds stock for the book : ${item.book_ID}`)
        }
    }

//    return cds.transaction(req).run (()=> orderItems.map (item =>
//     UPDATE(Books).set('stock -=', item.amount).where('ID =', item.book_ID).and('stock >=', item.amount)
//   )).then (all => all.forEach ((affectedRows,i) => {
//     if (affectedRows === 0) {
//       req.error (409, `${orderItems[i].amount} exceeds stock for book #${orderItems[i].book_ID}`)
//     }
//   }))
}

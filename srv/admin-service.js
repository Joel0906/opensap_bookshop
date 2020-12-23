const cds = require('@sap/cds')

module.exports = cds.service.impl(srv => {

    const { OrderItems } = srv.entities('joel.bookshop')
    srv.after(["READ", "EDIT"], 'Orders', _calculateTotal)


// on-the-fly calculate the total Order price based on the OrderItems' netAmounts
    function _calculateTotal(orders, req) {
        const tx = cds.transaction(req)

        const ordersById = Array.isArray(orders)
            ? orders.reduce((all, each) => { all[each.ID] = each; return all }, {})
            : {[orders.ID]: orders}

        return tx.run(
            SELECT.from(OrderItems).columns('netAmount', 'parent_ID')
            .where({ parent_ID: {in: Object.keys(ordersById)}})
        ).then(items => 
            items.forEach(item => ordersById[item.parent_ID].total += item.netAmount)
        )
    }
})




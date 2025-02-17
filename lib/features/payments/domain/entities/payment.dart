class Paymentodel {
    String? id;
    String? description;
    String? comments;
    double? amount;
    dynamic paymentMethod;
    dynamic owner;
    bool? status;
    dynamic creator;
    String? createdAt;
    String? updatedAt;

    Paymentodel({
        this.id,
        this.description,
        this.comments,
        this.amount,
        this.paymentMethod,
        this.owner,
        this.status,
        this.creator,
        this.createdAt,
        this.updatedAt,
    });
}
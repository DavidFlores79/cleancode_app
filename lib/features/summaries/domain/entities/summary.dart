class SummaryModel {
    String? image;
    String? id;
    String? title;
    String? comments;
    dynamic owner;
    bool? status;
    dynamic creator;
    String? createdAt;
    String? updatedAt;

    SummaryModel({
        this.image,
        this.id,
        this.title,
        this.comments,
        this.owner,
        this.status,
        this.creator,
        this.createdAt,
        this.updatedAt,
    });
}
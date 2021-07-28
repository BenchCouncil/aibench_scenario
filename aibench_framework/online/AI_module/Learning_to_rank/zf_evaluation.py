"""
Evalution methods used for evaluate the performance of ranking models.
"""
import numpy as np
import time


def _compute_apk(targets, predictions, k):

    if len(predictions) > k:
        predictions = predictions[:k]

    score = 0.0
    num_hits = 0.0

    for i, p in enumerate(predictions):
        if p in targets and p not in predictions[:i]:
            num_hits += 1.0
            score += num_hits / (i + 1.0)

    if not list(targets):
        return 0.0

    return score / min(len(targets), k)


def _compute_precision_recall(targets, predictions, k):

    pred = predictions[:k]
    num_hit = len(set(pred).intersection(set(targets)))
    precision = float(num_hit) / len(pred)
    recall = float(num_hit) / len(targets)
    return precision, recall


def _compute_ndcg(targets, predictions, k):
    k = min(len(targets), k)

    if len(predictions) > k:
        predictions = predictions[:k]

    # compute idcg
    idcg = np.sum(1 / np.log2(np.arange(2, k + 2)))
    dcg = 0.0
    for i, p in enumerate(predictions):
        if p in targets:
            dcg += 1 / np.log2(i + 2)
    ndcg = dcg / idcg

    return ndcg


def evaluate_ranking(model, test, train=None, k=10):
    """
    Compute Precision@k, Recall@k scores, nDCG@k and average precision (AP).
    One score is given for every user with interactions in the test
    set, representing the AP, Precision@k, Recall@k and nDCG@k of all their
    test items.

    Parameters
    ----------

    model: fitted instance of a recommender model
        The model to evaluate.
    test:
        Test interactions.
    train:
        Train interactions. If supplied, rated items in
        interactions will be excluded.
    k: int or array of int,
        The maximum number of predicted items
    """

    test = test.tocsr()

    if train is not None:
        train = train.tocsr()

    if not isinstance(k, list):
        ks = [k]
    else:
        ks = k

    precisions = [list() for _ in range(len(ks))]
    recalls = [list() for _ in range(len(ks))]
    ndcgs = [list() for _ in range(len(ks))]
    apks = list()

    zfi=0
    t0=time.time()
    for user_id, row in enumerate(test):
        zfi+=1
        if zfi>100:
            break
        if not len(row.indices):
            continue

        predictions = -model.predict(user_id)
        predictions = predictions.argsort()

        if train is not None:
            rated = set(train[user_id].indices)
        else:
            rated = []

        predictions = [p for p in predictions if p not in rated]

        print("zf user_id: {}, predictions: {}".format(user_id,np.array(predictions)))




    print("test time: {} s".format(time.time()-t0))

    return 0

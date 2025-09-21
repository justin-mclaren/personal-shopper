import Accelerate
import Foundation

enum Embeddings {
    static func cosineSimilarity(lhs: [Float], rhs: [Float]) -> Float {
        precondition(lhs.count == rhs.count, "Vectors must have the same dimension")
        var dot: Float = 0
        vDSP_dotpr(lhs, 1, rhs, 1, &dot, vDSP_Length(lhs.count))

        var lhsMagnitude: Float = 0
        var rhsMagnitude: Float = 0
        vDSP_svesq(lhs, 1, &lhsMagnitude, vDSP_Length(lhs.count))
        vDSP_svesq(rhs, 1, &rhsMagnitude, vDSP_Length(rhs.count))

        let denominator = sqrt(lhsMagnitude) * sqrt(rhsMagnitude)
        return denominator == 0 ? 0 : dot / denominator
    }
}
